import { reactive } from 'vue'

export const store = reactive({
  clockState : false,
  toggleClockState() {
    this.clockState = !this.clockState
  }
})