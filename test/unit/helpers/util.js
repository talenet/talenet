import * as avoriaz from 'avoriaz'
import i18n from '@/i18n'

export function mount (component, options) {
  if (!options.i18n) {
    options.i18n = i18n
  }

  return avoriaz.mount(component, options)
}
