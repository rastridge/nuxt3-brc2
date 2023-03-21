<template>
	<div>
		<div
			v-if="!memberTypeOptions || !memberAdminTypeOptions"
			class="spinner-border text-primary"
			role="status"
		>
			<span class="visually-hidden">Loading...</span>
		</div>
		<div v-else class="form-box">
			<FormKit
				type="form"
				v-model="state"
				submit-label="Submit"
				@submit="submitForm(state)"
			>
				<FormKit
					label="First Name"
					name="member_firstname"
					type="text"
					validation="required"
				/>
				<FormKit
					label="Last Name"
					name="member_lastname"
					type="text"
					validation="required"
				/>
				<FormKit
					type="email"
					label="Email address"
					name="account_email"
					validation="required|email"
				/>
				<FormKit
					type="number"
					label="Year joined"
					name="member_year"
					min="1966"
					step="1"
				/>
				<FormKit
					type="text"
					label="Street"
					name="account_addr_street"
					validation="required"
				/>
				<FormKit
					type="text"
					label="Street Ext"
					name="account_addr_street_ext"
				/>
				<FormKit
					type="text"
					label="City"
					name="account_addr_city"
					validation="required"
				/>
				<FormKit
					type="text"
					label="State"
					name="account_addr_state"
					validation="required"
				/>
				<FormKit
					type="text"
					label="Country"
					name="account_addr_country"
					validation="required"
				/>
				<FormKit
					type="text"
					label="Postal Code"
					name="account_addr_postal"
					validation="required | matches:/^[0-9]{5}$/"
				/>

				<FormKit
					type="tel"
					label="Phone number"
					name="account_addr_phone"
					placeholder="1##########"
					validation="required"
					:validation-messages="{
						matches: 'Phone number must be in the format +1##########',
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
				<FormKit
					type="select"
					label="Member type"
					placeholder="Select member type"
					name="member_type_id"
					:options="memberTypeOptions"
					validation="required"
				/>
				<FormKit
					type="select"
					label="Member Administrator role"
					placeholder="Select admin type"
					name="member_admin_type_id"
					:options="memberAdminTypeOptions"
					validation="required"
				/>
			</FormKit>
			<div class="mb-3">
				<Button @click.prevent="cancelForm()"> Cancel </Button>
			</div>
		</div>
	</div>
</template>

<script setup>
	import '@formkit/themes/genesis'
	import { useAuthStore } from '~~/stores/authStore'
	const auth = useAuthStore()
	const { $dayjs } = useNuxtApp()
	//
	// Outgoing
	//
	const emit = defineEmits(['submitted'])
	//
	// Incoming
	//
	const props = defineProps({
		id: { Number, default: 0 },
	})
	//
	// initialize form for add
	//
	let state = ref({})
	state.value.member_year = $dayjs().format('YYYY')
	state.value.member_show_phone = '1'
	state.value.member_show_addr = '1'
	state.value.newsletter_recipient = '1'
	state.value.mail_recipient = '0'
	state.value.sms_recipient = '1'

	//
	// edit if there is an id - add if not
	//
	if (props.id !== 0) {
		//
		// Initialize Edit form
		//
		const {
			data: formdata,
			pending,
			error,
			refresh,
		} = await useFetch(`/accounts/${props.id}`, {
			key: props.id,
			method: 'get',
			headers: {
				authorization: auth.user.token,
			},
		})
		state.value = formdata.value
	}

	// get member admin types for select
	const { data: memberAdminTypes } = await useFetch(
		'/accounts/memberadmintypes',
		{
			method: 'get',
			headers: {
				authorization: auth.user.token,
			},
		}
	)
	// convert for formkit
	const getMemberAdminTypeOptions = (mtypes) => {
		let result = []
		mtypes.map((old) => {
			let n = {}
			n.label = old.member_admin_type
			n.value = old.member_admin_type_id
			result.push(n)
		})
		return result
	}
	const memberAdminTypeOptions = getMemberAdminTypeOptions(
		memberAdminTypes.value
	)
	// get member types
	const { data: memberTypes } = await useFetch('/accounts/membertypes', {
		method: 'get',
		headers: {
			authorization: auth.user.token,
		},
	})
	// convert for formkit
	const getMemberTypeOptions = (memberTypes) => {
		let result = []
		memberTypes.map((old) => {
			let n = {}
			n.label = old.member_type
			n.value = old.member_type_id
			result.push(n)
		})
		return result
	}
	const memberTypeOptions = getMemberTypeOptions(memberTypes.value)

	// form handlers
	const submitForm = (state) => {
		emit('submitted', state)
	}

	const cancelForm = () => {
		navigateTo('/admin/accounts/men') // needs to be / for self register
	}
</script>
