<script setup>
	// import { useAuthStore } from '~/stores/authStore'
	import { useAlertStore } from '~/stores/alertStore'
	const alert = useAlertStore()
	// const auth = useAuthStore()
	const { onSubmitAdd } = useSubmit()

	definePageMeta({ layout: 'admin' })
	const saving = ref(false)
	//
	// Accounts form action
	//
	const onSubmit = function (form_state) {
		saving.value = true
		onSubmitAdd('accounts', form_state)
		saving.value = false
		navigateTo(`/admin/accounts/men`)
	}
	/* 	const onSubmit = async function (state) {
		const { data, pending, error } = await useFetch('/accounts/addone', {
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
	}*/
</script>

<template>
	<div>
		<Head>
			<Title>Add Account</Title>
		</Head>
		<common-header title="Add account" />
		<accounts-form @submitted="onSubmit" />
	</div>
</template>

<style scoped></style>
