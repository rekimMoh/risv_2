<?php

namespace App\Http\Controllers;

use App\Models\CompteRenduModel;
use App\Models\Etude;
use App\Models\Service;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class CompteRenduModelController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = CompteRenduModel::with('etude.Service'); // Uppercase S as per model method

        if ($request->search) {
            $query->where('titreCRM', 'like', '%'.$request->search.'%');
        }

        return Inertia::render('Admin/crm', [
            'models' => $query->orderBy('created_at', 'desc')->paginate(10),
            'services' => fn () => Service::all(),
            'etudes' => fn () => Etude::all(),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'titreCRM' => 'required|string|max:255',
            'contenuCRM' => 'nullable|string',
            'etude_id' => 'required|exists:etudes,IDEtude',
        ]);

        CompteRenduModel::create([
            'titreCRM' => $request->titreCRM,
            'contenuCRM' => $request->contenuCRM ?? '',
            'etude_id' => $request->etude_id,
            'UICRM' => Auth::id(),
            'etatCRM' => 1,
        ]);

        return redirect()->back();
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        $model = CompteRenduModel::findOrFail($id);

        $request->validate([
            'titreCRM' => 'required|string|max:255',
            'contenuCRM' => 'nullable|string',
            'etude_id' => 'required|exists:etudes,IDEtude',
        ]);

        $model->update([
            'titreCRM' => $request->titreCRM,
            'contenuCRM' => $request->contenuCRM ?? '',
            'etude_id' => $request->etude_id,
            'UICRM' => Auth::id(),
        ]);

        return redirect()->back();
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        CompteRenduModel::findOrFail($id)->delete();

        return redirect()->back();
    }

    /**
     * Duplicate the specified resource.
     */
    public function duplicate($id)
    {
        $original = CompteRenduModel::findOrFail($id);
        $new = $original->replicate();
        $new->titreCRM = $new->titreCRM.' (Copie)';
        $new->UICRM = Auth::id();
        $new->save();

        return redirect()->back();
    }

    /**
     * Toggle the status of the specified resource.
     */
    public function toggleStatus(Request $request)
    {
        $model = CompteRenduModel::findOrFail($request->id);
        $model->etatCRM = $request->etat == 1 ? 1 : 0;
        $model->save();

        return redirect()->back();
    }
}
