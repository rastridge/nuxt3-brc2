import { useAuthStore } from '~/stores/authStore'

export default async function useMembertypes() {
	const auth = useAuthStore()
	//
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
	//
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

	return {
		memberAdminTypeOptions,
		memberTypeOptions,
	}
}
