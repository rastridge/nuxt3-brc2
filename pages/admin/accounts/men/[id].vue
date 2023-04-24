<script setup>
	import sendEmail from '~/helpers/sendEmail.mjs'
	import { useAlertStore } from '~/stores/alertStore'
	import { useAuthStore } from '~/stores/authStore'
	const { FROM, FROM_NAME } = useRuntimeConfig()

	const auth = useAuthStore()

	const alert = useAlertStore()
	const { onSubmitEdit } = useSubmit()

	definePageMeta({ layout: 'admin' })

	//
	// Get account id to edit
	//
	const route = useRoute()
	const id = ref(route.params.id)
	//
	// Accounts form action
	//
	const onSubmit = async function (form_state) {
		await onSubmitEdit('accounts', form_state)
		// const msg = `The account of ${form_state.member_firstname} ${form_state.member_lastname} has been modified`
		// console.log(FROM, FROM_NAME)
		if (alert.message === null) {
			// 	const email_data = {
			// 		from: FROM,
			// 		fromName: FROM_NAME,
			// 		to: auth.user.admin_user_name,
			// 		subject: 'Buffalo Rugby Club Admin Account Modification',
			// 		body_text: '',
			// 		body_html: '<h3>' + msg + '</h3>',
			// 	}
			// 	console.log(email_data)
			// Can't use this sendmail on the browser side
			// Can't get admin use on server side !!!
			// sendEmail(email_data)
			navigateTo(`/admin/accounts/men`)
		}
	}
</script>

<template>
	<div>
		<Head>
			<Title>Edit Account {{ id }}</Title>
		</Head>
		<common-header title="Edit account" />
		<accounts-form :id="id" @submitted="onSubmit" />
	</div>
</template>
