<script setup>
	// import { useAuthStore } from '~/stores/authStore'
	import { useAlertStore } from '~/stores/alertStore'
	const alert = useAlertStore()
	// const auth = useAuthStore()
	const { onSubmitEdit } = useSubmit()

	definePageMeta({ layout: 'admin' })
	const saving = ref(false)

	//
	// Get account id to edit
	//
	const route = useRoute()
	const id = ref(route.params.id)

	//
	// Accounts form action
	//
	const onSubmit = function (form_state) {
		saving.value = true
		onSubmitEdit('accounts', form_state)
		saving.value = false
		navigateTo(`/admin/accounts/men`)
	}
	/* 	const onSubmit = async function (state) {
		const { data, pending, error } = await useFetch('/accounts/editone', {
			method: 'post',
			body: state,
			headers: {
				authorization: auth.user.token,
			},
		})
		if (data.value.message) {
			alert.error(data.value.message)
		} else {
			navigateTo('/admin/accounts/men')
		}
	} */
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
