<template>
	<div>
		<Head>
			<Title>News Items List</Title>
		</Head>
		<common-header title="News Items List" />

		<div v-if="pending" class="text-center text-2xl">Loading ...</div>
		<div v-else>
			<!--Select year -->
			<div class="text-center m-5">
				<select-year
					:startyear="startyear"
					@submitted="onSubmit"
					class="mb-3"
				/>
				<p class="text-2xl">{{ year }}</p>
			</div>

			<render-list
				:data="filteredData"
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
	// Initialize values for Renderlist and Select Year
	//

	const { getAccess } = useRenderListAccess()
	const app = 'news'
	const { editable, addable, deleteable, statusable, viewable } = getAccess(app)

	const startyear = ref(2020)
	const { $dayjs } = useNuxtApp()
	let year = ref(parseInt($dayjs().format('YYYY')))

	//
	// Get all news
	//
	const { data: news, pending } = await getAll('news')

	//
	// Select year action
	//
	const onSubmit = function (value) {
		// console.log('in onSubmit value = ', value)
		year.value = value
	}

	const filteredData = computed(() => {
		return news.value.filter((d) => {
			return parseInt($dayjs(d.dt).format('YYYY')) === year.value
		})
	})

	//
	// Renderlist actions
	//
	const deleteItem = async (id) => {
		await deleteOne('news', id)
	}

	const changeStatus = async ({ id, status }) => {
		await changeStatusOne('news', { id, status })
	}
</script>
