<template>
	<div class="form-box">
		<FormKit
			type="form"
			v-model="state"
			submit-label="Submit"
			@submit="submitForm"
		>
			<h4>* required</h4>
			<FormKit
				label="First Name *"
				name="member_firstname"
				type="text"
				validation="required"
			/>
			<FormKit
				label="Last Name *"
				name="member_lastname"
				type="text"
				validation="required"
			/>
			<FormKit
				type="email"
				label="Email address *"
				name="account_email"
				validation="required|email"
			/>

			<FormKit
				type="text"
				label="Street address *"
				name="account_addr_street"
				validation="required"
			/>
			<FormKit type="text" label="Street Ext" name="account_addr_street_ext" />
			<FormKit
				type="text"
				label="City *"
				name="account_addr_city"
				validation="required"
			/>
			<FormKit
				type="select"
				label="Country"
				name="account_addr_country"
				id="account_addr_country"
				:options="justCountries"
				validation="required"
			/>
			<FormKit
				type="select"
				label="Region"
				name="account_addr_state"
				id="account_addr_state"
				:options="justRegions"
				validation="required"
			/>
			<FormKit
				type="text"
				label="Postal Code *"
				name="account_addr_postal"
				validation="required | matches:/^[0-9]{5}$/"
			/>
			<FormKit
				type="tel"
				label="Phone number *"
				name="account_addr_phone"
				placeholder="1-###-###-####"
				v-model="state.account_addr_phone"
				validation="required | matches:/^[1]{1}-[0-9]{3}-[0-9]{3}-[0-9]{4}$/"
				:validation-messages="{
					matches: 'Phone number must be in the format 1-###-###-####',
				}"
			/>
			<FormKit
				type="select"
				label="Show phone?"
				name="member_show_phone"
				:options="[
					{ label: 'Yes', value: 1 },
					{ label: 'No', value: 0 },
				]"
			/>
			<FormKit
				type="select"
				label="Show address?"
				name="member_show_addr"
				:options="[
					{ label: 'Yes', value: 1 },
					{ label: 'No', value: 0 },
				]"
			/>
			<FormKit
				type="select"
				label="Receive newsletter?"
				name="newsletter_recipient"
				:options="[
					{ label: 'Yes', value: 1 },
					{ label: 'No', value: 0 },
				]"
			/>
			<FormKit
				type="select"
				label="Receive US Mail?"
				name="mail_recipient"
				:options="[
					{ label: 'Yes', value: 1 },
					{ label: 'No', value: 0 },
				]"
			/>
			<FormKit
				type="select"
				label="Receive SMS messages?"
				name="sms_recipient"
				:options="[
					{ label: 'Yes', value: 1 },
					{ label: 'No', value: 0 },
				]"
			/>
		</FormKit>
		<p v-if="alert.message !== null" :class="`alert ${alert.type}`">
			{{ alert.message }}
		</p>
		<div class="mb-3">
			<Button @click="cancelForm"> Cancel </Button>
		</div>
	</div>
</template>

<script setup>
	import { getNode } from '@formkit/core'
	import { useAlertStore } from '~/stores/alertStore'
	import '@formkit/themes/genesis'
	const { getCountries, setRegions } = useLocations()
	const alert = useAlertStore()
	const { $dayjs } = useNuxtApp()
	//
	// outgoing
	//
	const emit = defineEmits(['submitted'])
	//
	// initialize form
	//
	const state = ref({
		account_email: '',
		member_firstname: '',
		member_lastname: '',

		member_year: $dayjs().format('YYYY'),
		account_addr_street: '',
		account_addr_street_ext: '',
		account_addr_city: '',
		account_addr_state: 'NY',
		account_addr_country: 'US',
		account_addr_postal: '',
		account_addr_phone: '1-716',

		member_show_phone: '1',
		member_show_addr: '1',
		newsletter_recipient: '1',
		mail_recipient: '0',
		sms_recipient: '1',

		member_type_id: '9',
		member_type2_id: '',
		member_admin_type_id: '0',
		member_admin_type2_id: '',

		// human: '',
	})
	//
	// create coutry and region options formatted for Formkit
	const justCountries = ref(getCountries())
	// justCountries.value = getCountries()

	const justRegions = ref(setRegions(state.value.account_addr_country))

	//
	// form handlers
	//
	const submitForm = (state) => {
		emit('submitted', state)
	}

	const cancelForm = () => {
		navigateTo('/')
	}
	//
	// FormKit stuff
	// Region depends on country
	onMounted(() => {
		// Use the IDs of the inputs you want to get
		const countryNode = getNode('account_addr_country')
		const stateNode = getNode('account_addr_state')

		// Here we are listening for the 'commit' event
		countryNode.on('commit', ({ payload }) => {
			// We update the value of the regions
			justRegions.value = setRegions(payload)
		})
	})
</script>
