<script setup>
	// import { useAuthStore } from '~/stores/authStore'
	import { useAlertStore } from '~/stores/alertStore'
	const alert = useAlertStore()
	// const auth = useAuthStore()
	const { onSubmitAdd } = useSubmit()

	definePageMeta({ layout: 'admin' })
	const saving = ref(false)

	//
	// News form action
	//
	const onSubmit = function (form_state) {
		saving.value = true
		saving.value = onSubmitAdd('news', form_state)
		// saving.value = false
		navigateTo(`/admin/news`)
	}
	/* 	const onSubmit = async function (state) {
		const { data, pending, error } = await useFetch('/news/addone', {
			method: 'post',
			body: state,
			headers: {
				authorization: auth.user.token,
			},
		})
		if (data.value.message) {
			alert.error(data.value.message)
		} else {
			navigateTo('/admin/news')
		}
	} */
</script>

<template>
	<div>
		<Head>
			<Title>Add News Item</Title>
		</Head>
		<common-header title="Add News item" />
		<news-form @submitted="onSubmit" />
	</div>
</template>

<style scoped></style>
