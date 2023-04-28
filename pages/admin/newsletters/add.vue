<script setup>
	import Swal from 'sweetalert2'
	import { useAlertStore } from '~/stores/alertStore'
	const alert = useAlertStore()
	const { addNewsletter } = useNewsletter()

	definePageMeta({ layout: 'admin' })

	//
	// Newsletters form action
	//
	const onSubmit = async function (state) {
		Swal.fire({
			title: 'What to do?',
			showDenyButton: true,
			showCancelButton: true,
			showConfirmButton: true,
			confirmButtonText: `Send now`,
			denyButtonText: `Send later`,
		}).then((result) => {
			if (result.isConfirmed) {
				addNewsletter(state, 'sendNow')
				Swal.fire('Saved and Sent', '', 'success')
			} else if (result.isDenied) {
				addNewsletter(state, 'sendLater')
				Swal.fire('Saved', '', 'success')
			} else if (result.isDismissed) {
				// this.submitStatus = ''
			}
		})
	}

	// const { onSendSave } = useSendSave()
	// onSendSave(state.value, useAddNewsletter())
</script>

<template>
	<div>
		<Head>
			<Title>Add Newsletter</Title>
		</Head>
		<common-header title="Add Newsletter" />
		<newsletters-form @submitted="onSubmit" />
		<!-- <newsletters-form @submitted="onSendSave" /> -->
	</div>
</template>

<style lang="scss" scoped>
	@import 'sweetalert2/src/sweetalert2.scss';
</style>
