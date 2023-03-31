<template>
	<div>
		<Head>
			<Title>Accounts List</Title>
		</Head>
		<common-header title="Account List" />
		<div v-if="pending" class="text-center text-2xl">Loading ...</div>

		<div v-else>
			<render-list
				:data="accounts"
				:app="app"
				:statusable="statusable"
				:editable="editable"
				:deleteable="deleteable"
				:addable="addable"
				:viewable="viewable"
				@changeStatus="changeStatus"
				@deleteItem="deleteItem"
			/>
		</div>
	</div>
</template>

<script setup>
	import { useAuthStore } from '~~/stores/authStore'
	const auth = useAuthStore()

	definePageMeta({ layout: 'admin' })

	//
	// Initialize values for Renderlist
	//
	const { getAccess } = useRenderListAccess()

	const app = 'accounts/men'
	const { editable, addable, deleteable, statusable, viewable } = getAccess(app)

	//
	// Get all accounts
	//
	const {
		data: accounts,
		pending,
		error,
		refresh,
	} = await useFetch('/accounts/getall', {
		lazy: true,
		method: 'get',
		headers: {
			authorization: auth.user.token,
			// authorization: 'not-needed',
		},
	})
	//
	// Renderlist actions
	//
	const deleteItem = async (id) => {
		const { pending, error, refresh } = await useFetch(`/accounts/${id}`, {
			method: 'delete',
			headers: {
				authorization: auth.user.token,
			},
		})
	}

	const changeStatus = async ({ id, status }) => {
		const { pending, error, refresh } = await useFetch(`/accounts/status`, {
			method: 'POST',
			headers: {
				authorization: auth.user.token,
			},
			body: { id, status },
		})
	}
</script>
