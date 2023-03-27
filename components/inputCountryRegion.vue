<template>
	<div>
		<!-- 		allCountries[0][2][0][1]
		{{ allCountries[0][2][0][1] }}<br />
		justRegions {{ justRegions }} -->
		<FormKit
			type="select"
			label="Country"
			v-model="state.account_addr_country"
			@input="submitCountry(state)"
			:options="justCountries"
			validation="required"
		/>

		<FormKit
			type="select"
			label="Region"
			v-model="state.account_addr_state"
			@input="submitState(state)"
			:options="justRegions"
			validation="required"
		/>
		<!-- IN component fields prop = {{ fields }}<br /><br />
		IN component state = {{ state }}<br /><br /> -->
		<!-- IN cjustregaion = {{ justRegions }}<br /><br /> -->
	</div>
</template>

<script setup>
	import { allCountries } from 'country-region-data'
	import '@formkit/themes/genesis'
	import { useAuthStore } from '~~/stores/authStore'
	const auth = useAuthStore()

	//
	// Incoming
	//
	const props = defineProps({
		fields: { type: Object, required: true },
	})
	const state = ref(props.fields)

	//
	// outgoing
	//
	const emit = defineEmits(['changeLocation'])

	const submitCountry = (state) => {
		changeRegions()
	}
	const submitState = (state) => {
		emit('changeLocation', state)
	}

	// format for Formkit
	const justRegions = ref([])
	const justCountries = ref([])

	let c = []
	for (let i = 0; i < allCountries.length; i++) {
		let n = {}
		n.label = allCountries[i][0]
		n.value = allCountries[i][1]
		c.push(n)
	}
	justCountries.value = c

	// format justRegions for Formkit
	// const justRegions = computed(() => {
	const changeRegions = () => {
		let r = []
		for (let i = 0; i < allCountries.length; i++) {
			let h = state.value.account_addr_country
			if (allCountries[i][1] === state.value.account_addr_country) {
				console.log('i = ', i)
				r = []
				for (let k = 0; k < allCountries[i][2].length; k++) {
					let n = {}
					n.label = allCountries[i][2][k][0]
					n.value = allCountries[i][2][k][1]
					console.log('n, i = ', n, i)
					r.push(n)
				}
			}
		}
		justRegions.value = r
	}
</script>

<style scoped></style>
