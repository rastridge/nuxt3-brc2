<script setup>
	import { useAlertStore } from '~/stores/alertStore'
	const alert = useAlertStore()
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
		if (!alert.message) {
			navigateTo(`/admin/accounts/men`)
		}
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
		<div v-if="saving">Saving . . .</div>
		<common-header title="Add account" />
		<p v-if="alert.message" :class="`alert ${alert.type}`">
			{{ alert.message }}
		</p>

		<accounts-form @submitted="onSubmit" />
	</div>
</template>

<style scoped></style>
