import { useLocation } from 'react-router-dom'

// TODO: maybe add polyfill to support IE 11
const useQueryParams = () => new URLSearchParams(useLocation().search)

export default useQueryParams
