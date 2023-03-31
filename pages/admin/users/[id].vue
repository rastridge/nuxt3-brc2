<template>
	<div>
		<Head>
			<Title>Edit User {{ id }}</Title>
		</Head>
		<common-header title="Edit users" />

		<div v-if="alert.message" :class="`alert ${alert.type}`">
			{{ alert.message }}
		</div>
		<p v-if="saving" class="text-center text-2xl">Saving ...</p>
		<div v-else>
			<user-form :id="id" @submitted="onSubmit" />
		</div>
	</div>
</template>

<script setup>
	import { useAuthStore } from '~~/stores/authStore'
	import { useAlertStore } from '~~/stores/alertStore'
	const alert = useAlertStore()
	const auth = useAuthStore()

	definePageMeta({ layout: 'admin' })
	//
	// Get user id
	//
	const route = useRoute()
	const id = ref(route.params.id)
	const saving = ref(false)

	//
	// Users form action
	//
	const onSubmit = function (form_state) {
		const { data, pending, error } = useFetch('/users/editone', {
			lazy: true,
			method: 'post',
			body: form_state,
			headers: {
				authorization: auth.user.token,
			},
		})
		saving.value = pending.value
		if (data.value.message) {
			alert.error(data.value.message)
		} else {
			navigateTo('/admin/users')
		}
	}
</script>
