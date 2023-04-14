<script setup>
	// import { useAuthStore } from '~~/stores/authStore'
	import { useAlertStore } from '~~/stores/alertStore'
	const alert = useAlertStore()
	// const auth = useAuthStore()
	const { onSubmitEdit } = useSubmit()

	definePageMeta({ layout: 'admin' })
	const saving = ref(false)

	//
	// Get content item id
	//
	const route = useRoute()
	const id = ref(route.params.id)

	//
	// content form action
	//
	const onSubmit = function (form_state) {
		saving.value = true
		onSubmitEdit('content', form_state)
		saving.value = false
		navigateTo(`/admin/content`)
	}
	/* 	const onSubmit = async function (state) {
		const { data, pending, error } = await useFetch('/content/editone', {
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
			<Title>Edit custom page {{ id }}</Title>
		</Head>
		<common-header title="Edit custom page" />

		<div v-if="alert.message" :class="`alert ${alert.type}`">
			{{ alert.message }}
		</div>

		<content-form :id="id" @submitted="onSubmit" />
	</div>
</template>
