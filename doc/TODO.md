# random musings what code structures we need

## about messages

the information like who is known by which name and stuff like profile picutres are realized with `{type: about}` messages.

it would be good to have a structure in the store that reflects this.
ie. store.namesOf(id) => {
  list:[{"john",5}, {"johny",1}]
  pickedByMe: 1, # index into list?
  puckedByThem: 0,
}
