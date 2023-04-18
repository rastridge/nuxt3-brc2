<script setup>
	// import { useAuthStore } from '~/stores/authStore'
	import { useAlertStore } from '~/stores/alertStore'
	const alert = useAlertStore()
	// const auth = useAuthStore()
	const { onSubmitEdit } = useSubmit()

	definePageMeta({ layout: 'admin' })
	const saving = ref(false)

	//
	// Get news item id
	//
	const route = useRoute()
	const id = ref(route.params.id)

	//
	// News form action
	//
	const onSubmit = function (form_state) {
		saving.value = true
		onSubmitEdit('news', form_state)
		saving.value = false
		navigateTo(`/admin/news`)
	}
	/* 	const onSubmit = async function (state) {
		const { data, pending, error } = await useFetch('/news/editone', {
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
			<Title>Edit News Item {{ id }}</Title>
		</Head>
		<common-header title="Edit News Item" />
		<news-form :id="id" @submitted="onSubmit" />
	</div>
</template>
