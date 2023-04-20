import { useAuthStore } from '~/stores/authStore'
import { useAlertStore } from '~/stores/alertStore'
const alert = useAlertStore()
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
		const { data, error } = useFetch(`/${app}/addone`, {
			method: 'post',
			body: form_state,
			headers: {
				authorization: auth.user.token,
			},
		})
		console.log('IN onSubmitAdd data.value.message = ', data.value.message)

		if (data.value.message) {
			console.log('IN if data.value.message')
			alert.error(data.value.message)
		}
		/* if (error.value) {
			throw createError({
				...error.value,
				statusMessage: `Error submitting data to /${app}/addone`,
			})
		} else {
			if (data.value.message) {
				alert.error(data.value.message)
			} else {
				navigateTo('/admin/accounts/men')
			}
		} */
	}
	return { onSubmitEdit, onSubmitAdd }
}
