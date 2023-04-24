<template>
	<!-- Modal for errors-->
	<Dialog
		header="Warning"
		v-model:visible="displayModal"
		:breakpoints="{ '960px': '75vw', '640px': '90vw' }"
		:style="{ width: '50vw' }"
	>
		<p :class="`alert ${alert.type}`">
			{{ alert.message }}
		</p>
		<template #footer>
			<Button label="OK" @click="closeModal" class="p-button-sm" autofocus />
		</template>
	</Dialog>
</template>

<script setup>
	import Dialog from 'primevue/dialog'
	import { useAlertStore } from '~/stores/alertStore'
	const alert = useAlertStore()
	const displayModal = ref(alert.message !== null)
	const closeModal = () => {
		displayModal.value = false
	}
</script>
