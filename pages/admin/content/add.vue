<script setup>
	import { useAuthStore } from '~/stores/authStore'
	import { useAlertStore } from '~/stores/alertStore'
	const alert = useAlertStore()
	const auth = useAuthStore()
	const { onSubmitAdd } = useSubmit()

	definePageMeta({ layout: 'admin' })
	const saving = ref(false)
	const app = ref('content')
	//
	// News form action
	//
	const onSubmit = function (form_state) {
		saving.value = true
		onSubmitAdd(app.value, form_state)
		// navigateTo(`/admin/content`)
	}
	/* 	const onSubmit = async function (state) {
		const { data, pending, error } = await useFetch('/content/addone', {
			method: 'post',
			body: state,
			headers: {
				authorization: auth.user.token,
			},
		})
				if (data.value.message) {
			alert.error(data.value.message)
		} else {
			navigateTo('/admin/content')
		}
	} */
</script>

<template>
	<div>
		<Head>
			<Title>Add Custom page</Title>
		</Head>
		<common-header title="Add Custom page" />
		<content-form @submitted="onSubmit" />
	</div>
</template>
