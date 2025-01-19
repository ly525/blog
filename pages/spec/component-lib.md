<script setup>
import useCompStore from '@store/copname.js'
import { onMounted } from 'vue'
const compStore =useCompStore()

onMounted(()=>{
  compStore.updateName('')
})

</script>

