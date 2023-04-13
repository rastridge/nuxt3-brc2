<template>
	<div>
		<Head>
			<Title>Custom pages List</Title>
		</Head>
		<common-header title="Custom pages List" />

		<div v-if="pending" class="text-center text-2xl">Loading ...</div>
		<div v-else>
			<render-list
				:data="content_data"
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
	const { getAll, deleteOne, changeStatusOne } = useFetchAll()

	definePageMeta({ layout: 'admin' })

	//
	// Initialize values for Renderlist
	//
	const { getAccess } = useRenderListAccess()
	const app = 'content'
	const { editable, addable, deleteable, statusable, viewable } = getAccess(app)

	//
	// Get all news
	//

	const { data: content_data, pending } = await getAll('content')

	//
	// Renderlist actions
	//
	const deleteItem = async (id) => {
		await deleteOne('content', id)
	}

	const changeStatus = async ({ id, status }) => {
		await changeStatusOne('content', { id, status })
	}
</script>
