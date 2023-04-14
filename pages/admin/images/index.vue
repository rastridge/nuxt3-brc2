<template>
	<div>
		<Head>
			<Title>Images List</Title>
		</Head>
		<common-header title="Images List" />
		<div v-if="pending" class="text-center text-2xl">Loading ...</div>
		<div v-else>
			<render-list
				:data="images_data"
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
	const app = 'images'
	const { editable, addable, deleteable, statusable, viewable } = getAccess(app)

	//
	// Get all images
	//
	const { data: images_data, pending } = await getAll('images')

	//
	// Renderlist actions
	//
	const deleteItem = async (id) => {
		await deleteOne('images', id)
	}
	const changeStatus = async ({ id, status }) => {
		await changeStatusOne('images', { id, status })
	}
</script>
