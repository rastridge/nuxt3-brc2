<template>
	<div class="register">
		<common-header title="Register" />
		<accounts-self-form @submitted="handleSubmit" />

		<!-- Modal Advise of non commitment on opening of form-->
		<Dialog
			header="Register"
			v-model:visible="displayModal"
			:breakpoints="{ '960px': '75vw', '640px': '90vw' }"
			:style="{ width: '50vw' }"
		>
			<p>
				Registering is an expression of interest in being informed of Buffalo
				Rugby Club activities and does not imply any commitment. Give us a try
				and see if we're right for you.
			</p>
			<template #footer>
				<Button
					label="Return"
					@click="closeModal"
					class="p-button-sm"
					autofocus
				/>
			</template>
		</Dialog>
	</div>
</template>

<script setup>
	import Dialog from 'primevue/dialog'
	import { useAlertStore } from '~/stores/alertStore'
	const alert = useAlertStore()
	const { $dayjs } = useNuxtApp()
	//
	// control modal
	//
	const displayModal = ref(true)
	const closeModal = () => {
		displayModal.value = false
	}
	//
	// Handle submitted form
	//
	const handleSubmit = async function (state) {
		const { data, pending, error } = await useFetch('/accounts/addone', {
			method: 'post',
			body: state,
			headers: {
				authorization: 'not-needed',
			},
		})
		alert.clear()
		if (error.value) {
			throw createError({
				...error.value,
				statusMessage: `Error submitting data to /${app}/addone`,
			})
		} else {
			if (data.value.message) {
				alert.error(data.value.message)
			} else {
				navigateTo('/')
			}
		}
	}
</script>
