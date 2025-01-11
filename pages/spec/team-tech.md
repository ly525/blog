<script setup>
import useCompStore from '@store/copname.js'
import { onMounted } from 'vue'
const compStore = useCompStore()

onMounted(() => {
  compStore.updateName('')
})

</script>

# 技术选型

<iframe src="https://kdocs.cn/l/cmYVW2pNaK8J" style="border:none;" width="100%" height="600px"></iframe>