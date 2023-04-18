import { useAuthStore } from '~/stores/authStore'

export default function useSubmit() {
	const auth = useAuthStore()
	const onSubmitEdit = function (app, form_state) {
		// saving.value = true
		const { data, pending, error } = useLazyFetch(`/${app}/editone`, {
			method: 'post',
			body: form_state,
			headers: {
				authorization: auth.user.token,
			},
		})
		// saving.value = pending.value
		if (error.value) {
			throw createError({
				...error.value,
				statusMessage: `Could not submit data to /${app}/editone`,
			})
		} else {
			navigateTo(`/admin/${app}`)
		}
	}
	const onSubmitAdd = function (app, form_state) {
		// console.log('form_state = ', form_state)
		const { error } = useFetch(`/${app}/addone`, {
			method: 'post',
			body: form_state,
			headers: {
				authorization: auth.user.token,
			},
		})
		// saving.value = pending.value
		if (error.value) {
			throw createError({
				...error.value,
				statusMessage: `Error submitting data to /${app}/addone`,
			})
		} else {
			navigateTo(`/admin/${app}`)
		}
	}
	return { onSubmitEdit, onSubmitAdd }
}
