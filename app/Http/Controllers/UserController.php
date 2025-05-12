<?php

namespace App\Http\Controllers;

use App\Models\Etude;
use App\Models\Lien;
use App\Models\User;
use App\Models\Service;
use App\Models\LienUser;
use App\Models\ModePaiement;
use App\Models\Shift;
use App\Models\UserMetier;
use Illuminate\Http\Request;
use Inertia\Inertia;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

        $users = User::with('userMetier')->with('LienUsers')->with('ModePaiements')->paginate(10);
        
        $liens = Lien::all();
        $userMeiters = UserMetier::all();
        $services = Service::with('etudes')->with('etudes.shifts')->get();
        $medcins = User::where('userMeiter_id', 2)->whereNull('signature_medcin')->get();   

        return Inertia::render('Admin/User', [
            'Users' => $users,
            'liens' => $liens,
            'userMeiters' => $userMeiters,
            'services' => $services,
            'medcins' => $medcins,
        ]);
    }


    public function getRadiologue()
    {
        return User::where([
            ['userMeiter_id', 3],
            ['is_active', 1],
        ])->get();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        $user = new User();

        $user->nom  = $request->nom;
        $user->prenom  = $request->prenom;
        $user->email  = $request->email;
        $user->password  = bcrypt($request->password);
        $user->userMeiter_id  = $request->userMeiter_id;
        $user->signature_medcin  = $request->signature_medcin;
        $user->save();

        foreach ($request->lien as $item) {
            // LienUser::create(['lien_id'=>$item, 'user_id'=>$user->id ]);
            $LienUser = new LienUser();

            $LienUser->lien_id = $item;
            $LienUser->user_id = $user->id;

            $LienUser->save();
        }

        foreach ($request->paiements as $service) {
            foreach ($service['etudes'] as $etude) {
                foreach ($etude['shifts'] as $index => $shift) {
                    if ($shift['value'] != null || $shift['value'] != 0) {
                        $revenu = new ModePaiement();
                        $revenu->user_id = $user->id;
                        $revenu->etude_id = $etude['IDEtude'];
                        $revenu->shift_id = $shift['IDShift'];
                        $revenu->service_id = $service['IDService'];
                        $revenu->pourcentage = $etude['pourcentage'];
                        $revenu->pourcentage = $etude['pourcentage'];
                        $revenu->pourcentageSRV = $service['pourcentageSRV'];
                        $revenu->value = $shift['value'];
                        $revenu->valueSRV = $service['shiftsSRV'][$index]['valueSRV'];
                        $revenu->save();
                    }
                }
            }
        }

        return $user;
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $user = User::find($id);

        $lienByUser = LienUser::where('user_id', '=', $id)->select('lien_id')->get();
        $liens = [];
        foreach ($lienByUser as $item) {
            array_push($liens, $item->lien_id);
        }
        $user->lien = $liens;

        $services = Service::all();

        $etudes = Etude::all();

        $shifts = Shift::all();

        $modePaiement = ModePaiement::where('user_id', $id)->get();


        $paiements = [];
        if (count($modePaiement) > 0) {
            foreach ($services as $srvKey => $srv) {
                $srvArray = [
                    'IDService' => $srv->IDService,
                    'etudes' => [],
                    'libelleService' => $srv->libelleService,
                    'pourcentageSRV' => true,
                    'shiftsSRV' => []
                ];
                array_push($paiements, $srvArray);
                foreach ($etudes as $etudeKey => $etude) {
                    if ($srv->IDService == $etude->service_id) {

                        $eudeArry = [
                            'IDEtude' => $etude->IDEtude,
                            'libelleEtude' => $etude->libelleEtude,
                            'pourcentage' => true,
                            'shifts' => []
                        ];
                        array_push($paiements[$srvKey]['etudes'], $eudeArry);
                        foreach ($shifts as $shiftKey => $shift) {
                            $shiftArry = [
                                'IDShift' => $shift->IDShift,
                                'libelleShift' => $shift->libelleShift,
                                'value' => 0
                            ];
                            $shiftSRVArry = [
                                'IDShift' => $shift->IDShift,
                                'libelleShift' => $shift->libelleShift,
                                'valueSRV' => 0
                            ];

                            $indexEtude = count($paiements[$srvKey]['etudes']) - 1;

                            foreach ($modePaiement as $mode) {
                                if (
                                    $mode->etude_id == $etude->IDEtude &&
                                    $mode->shift_id == $shift->IDShift
                                ) {
                                    $paiements[$srvKey]['etudes'][$indexEtude]['pourcentage']  = $mode->pourcentage;
                                    $paiements[$srvKey]['pourcentageSRV'] = $mode->pourcentageSRV;
                                    $shiftArry['value'] = $mode->value;
                                    $shiftSRVArry['valueSRV'] = $mode->valueSRV;

                                }
                            }

                            array_push($paiements[$srvKey]['etudes'][$indexEtude]['shifts'], $shiftArry);
                            array_push($paiements[$srvKey]['shiftsSRV'], $shiftSRVArry);

                        }
                    }
                }
            }
        }

        foreach($paiements as $k=>$p){
            if(count($p['etudes']) == 0){
                unset($paiements[$k]);
            }
        }
        
        $user->paiements = $paiements;
        return ['user' => $user];
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $user = User::find($id);

        $user->nom  = $request->nom;
        $user->prenom  = $request->prenom;
        $user->email  = $request->email;
        if (isset($request->password) && !empty($request->password)) {

            $user->password  = bcrypt($request->password);
        }
        $user->userMeiter_id  = $request->userMeiter_id;
        $user->signature_medcin  = $request->signature_medcin;
        $user->save();

        LienUser::where('user_id', $id)->delete();

        foreach ($request->lien as $item) {
            // LienUser::create(['lien_id'=>$item, 'user_id'=>$user->id ]);
            $LienUser = new LienUser();

            $LienUser->lien_id = $item;
            $LienUser->user_id = $user->id;

            $LienUser->save();
        }

        ModePaiement::where('user_id',$id)->delete();

        foreach ($request->paiements as $service) {
            foreach ($service['etudes'] as $etude) {
                foreach ($etude['shifts'] as $index => $shift) {
                    if ($shift['value'] != null || $shift['value'] != 0) {
                        $revenu = new ModePaiement();
                        $revenu->user_id = $user->id;
                        $revenu->etude_id = $etude['IDEtude'];
                        $revenu->shift_id = $shift['IDShift'];
                        $revenu->service_id = $service['IDService'];
                        $revenu->pourcentage = $etude['pourcentage'];
                        $revenu->pourcentage = $etude['pourcentage'];
                        $revenu->pourcentageSRV = $service['pourcentageSRV'];
                        $revenu->value = $shift['value'];
                        $revenu->valueSRV = $service['shiftsSRV'][$index]['valueSRV'];
                        $revenu->save();
                    }
                }
            }
        }

        

        return $user;
    }

    public function activeCompte(Request $request)
    {
        $user = User::find($request->id);

        $user->is_active = $request->is_active;
        $user->save();
        return $user;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        LienUser::where('user_id', $id)->delete();
        User::where('id', $id)->delete();
    }


    /**
     * Get List of doctor list
     * @return \Illuminate\Http\Response
     */
    function getListMedcin()
    {

        return User::leftJoin('user_metiers', 'users.userMeiter_id', '=', 'user_metiers.IDUserMetier')
            ->where('user_metiers.IDUserMetier', 2)
            ->get();
    }
}
