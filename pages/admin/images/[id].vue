<script setup>
	// import { useAuthStore } from '~/stores/authStore'
	import { useAlertStore } from '~/stores/alertStore'
	const alert = useAlertStore()
	// const auth = useAuthStore()
	const { onSubmitEdit } = useSubmit()

	definePageMeta({ layout: 'admin' })
	const saving = ref(false)

	//
	// Get images item id
	//
	const route = useRoute()
	const id = ref(route.params.id)

	//
	// images form action
	//
	const onSubmit = function (form_state) {
		saving.value = true
		onSubmitEdit('images', form_state)
		saving.value = false
		navigateTo(`/admin/images`)
	}
	/* const onSubmit = async function (state) {
		const { data, pending, error } = await useFetch('/images/editone', {
			method: 'post',
			body: state,
			headers: {
				authorization: auth.user.token,
			},
		})
		if (error.value) {
			alert.error(error.value.message)
		} else {
			navigateTo('/admin/images')
		}
	} */
</script>

<template>
	<div>
		<Head>
			<Title>Edit image {{ id }}</Title>
		</Head>
		<common-header title="Edit image" />
		<images-form :id="id" @submitted="onSubmit" />
	</div>
</template>
