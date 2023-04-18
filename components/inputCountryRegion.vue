<template>
	<div>
		fieldset {{ fieldset }}
		<FormKit
			type="select"
			label="Country"
			v-model="fieldset.account_addr_country"
			@input="submitCountry"
			:options="justCountries"
			validation="required"
		/>
		<FormKit
			type="select"
			label="Region"
			v-model="fieldset.account_addr_state"
			@input="submitState"
			:options="justRegions"
			validation="required"
		/>
	</div>
</template>

<script setup>
	import { allCountries } from 'country-region-data'
	import '@formkit/themes/genesis'
	import { useAuthStore } from '~/stores/authStore'
	const auth = useAuthStore()

	//
	// Incoming
	//
	const props = defineProps({
		fields: { type: Object, required: true },
	})
	const fieldset = ref(props.fields)

	//
	// outgoing
	//
	const emit = defineEmits(['changeLocation'])

	const submitCountry = () => {
		setRegions()
	}
	const submitState = () => {
		console.log('IN submitState fieldset = ', fieldset)
		emit('changeLocation', {
			account_addr_country: fieldset.value.account_addr_country,
			account_addr_state: fieldset.value.account_addr_state,
		})
	}

	// format for Formkit
	const justRegions = ref([])
	const justCountries = ref([])

	let countries = []
	for (let i = 0; i < allCountries.length; i++) {
		let n = {}
		n.label = allCountries[i][0]
		n.value = allCountries[i][1]
		countries.push(n)
	}
	justCountries.value = countries

	// get regions for country
	const setRegions = () => {
		let regions = []

		for (let i = 0; i < allCountries.length; i++) {
			if (allCountries[i][1] === fieldset.value.account_addr_country) {
				// format justRegions for Formkit
				regions = []
				for (let k = 0; k < allCountries[i][2].length; k++) {
					let n = {}
					n.label = allCountries[i][2][k][0]
					n.value = allCountries[i][2][k][1]
					// console.log('n, i = ', n, i)
					regions.push(n)
				}
				fieldset.value.account_addr_state = regions[0].value
				break
			}
		}
		justRegions.value = regions
	}
</script>
