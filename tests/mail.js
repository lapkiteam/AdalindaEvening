// @ts-check
import update from "immutability-helper"
import { Mutex } from "@fering-org/functional-helper"

/**
 * @template T
 * @typedef {Object} State
 * @property {T[]} newValue
 * @property {(value: T[]) => void} [subscriber]
 */

export const State = {
  /**
   * @template T
   * @return {State<T>}
   */
  create() {
    return {
      newValue: [],
      subscriber: undefined,
    }
  }
}

export const Mail = {
  /**
   * @template T
   * @return {State<T>}
   */
  create() {
    return State.create()
  },
  /**
   * @template T
   * @param {State<T>} state
   * @param {(value: T[]) => void} callback
   */
  subscribeOnce(state, callback) {
    const newValue = state.newValue
    if (newValue) {
      callback(newValue)
      return update(state, {
        newValue: { $set: [] }
      })
    }
    return update(state, {
      subscriber: { $set: callback }
    })
  },

  /**
   * @template T
   * @param {State<T>} state
   * @param {T} newValue
   */
  push(state, newValue) {
    const subscriber = state.subscriber
    if (subscriber) {
      subscriber([newValue])
      return update(state, {
        subscriber: { $set: undefined }
      })
    }
    return update(state, {
      newValue: { $push: [newValue] }
    })
  },
}

/**
 * @template T
 * @typedef {Object} MutableMail
 * @property {(callback: (value: T[]) => void) => void} subscribeOnce
 * @property {(newValue: T) => void} push
 */

/**
 * @template T
 * @return {MutableMail<T>}
 */
export function MutableMail() {
  const state = (() => {
    /** @type {State<T>} */
    let state = Mail.create()
    const lock = Mutex.create()

    return {
      get() {
        return lock.monitor(() => {
          return Promise.resolve(state)
        })
      },
      /**
       * @param {(state: State<T>) => State<T>} updater
       */
      async update(updater) {
        return lock.monitor(() => {
          state = updater(state)
          return Promise.resolve()
        })
      },
    }
  })()

  return {
    /**
     * @param {(value: T[]) => void} callback
     */
    subscribeOnce(callback) {
      state.update(state =>
        Mail.subscribeOnce(state, callback))
    },
    /**
     * @param {T} newValue
     */
    push(newValue) {
      state.update(state =>
        Mail.push(state, newValue))
    }
  }
}
