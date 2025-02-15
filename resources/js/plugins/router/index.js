import { createRouter, createMemoryHistory } from 'vue-router'
import { routes } from './routes'

const router = createRouter({
  history: createMemoryHistory(),
  routes,
})

export default function (app) {
  app.use(router)
}
export { router }
