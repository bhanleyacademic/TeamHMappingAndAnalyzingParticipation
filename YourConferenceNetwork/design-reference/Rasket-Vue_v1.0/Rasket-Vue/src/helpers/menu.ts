import { BASE_MENU_ITEMS, ADMIN_MENU_ITEMS } from '@/assets/data/menu'
import type { MenuItemType } from '@/types/menu'
import type { RouteRecordName } from 'vue-router'
import type { User } from '@/types/auth'

let activeMenuItem = {}

/** Return the menu items for the given user. Admin section appended for role=admin. */
export const getMenuItems = (user?: User | null): MenuItemType[] => {
  if (user?.role === 'admin') {
    return [...BASE_MENU_ITEMS, ...ADMIN_MENU_ITEMS]
  }
  return BASE_MENU_ITEMS
}

const allMenuItems = () => [...BASE_MENU_ITEMS, ...ADMIN_MENU_ITEMS]

const getMatchingMenuItems = (data: MenuItemType[], currentRouteName: RouteRecordName | null | undefined) => {
  const matchingItems: string[] = []

  const traverse = (item: MenuItemType) => {
    if (item.children && item.children.some((child) => child.route?.name && child.route.name === currentRouteName)) {
      matchingItems.push(item.key)
      if (item.parentKey) {
        matchingItems.push(item.parentKey)
      }
    }
    if (item.children) {
      item.children.forEach((child) => traverse(child))
    }
  }

  data.forEach(traverse)
  return matchingItems
}

export const menuItemActive = (key: string, currentRouteName: RouteRecordName | null | undefined) => {
  activeMenuItem = getMatchingMenuItems(allMenuItems(), currentRouteName)
  return activeMenuItem && Object.values(activeMenuItem).includes(key)
}
