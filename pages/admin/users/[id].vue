<template>
	<div>
		<Head>
			<Title>Edit User {{ id }}</Title>
		</Head>
		<common-header title="Edit users" />

		<p v-if="saving" class="text-center text-2xl">Saving ...</p>
		<div v-else>
			<user-form :id="id" @submitted="onSubmit" />
		</div>
	</div>
</template>

<script setup>
	// import { useAuthStore } from '~/stores/authStore'
	import { useAlertStore } from '~/stores/alertStore'
	const alert = useAlertStore()
	// const auth = useAuthStore()
	const { onSubmitEdit } = useSubmit()

	definePageMeta({ layout: 'admin' })
	const saving = ref(false)
	//
	// Get user id
	//
	const route = useRoute()
	const id = ref(route.params.id)

	//
	// Users form action
	//
	const onSubmit = function (form_state) {
		saving.value = true
		onSubmitEdit('users', form_state)
		saving.value = false
		navigateTo(`/admin/users`)
	}
	/* 	const onSubmit = function (form_state) {
		saving.value = true
		const { data, pending, error } = useLazyFetch('/users/editone', {
			method: 'post',
			body: form_state,
			headers: {
				authorization: auth.user.token,
			},
		})
		saving.value = pending.value
		if (error.value) {
			throw createError({
				...error.value,
				statusMessage: `Could not get data from /users/editone`,
			})
		} else {
			navigateTo('/admin/users')
		}
	} */
</script>
