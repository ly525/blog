import { defineStore } from 'pinia'

const useCompStore = defineStore({
  id: 'comp',
  state: () => {
    return {
      currentName: ''
    }
  },
  actions: {
    updateName (name) {
      this.currentName = name
    }
  }
})
export default useCompStore
