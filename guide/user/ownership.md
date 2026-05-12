# Ownership

Siisurit implements _task ownership_ based on the idea of [code ownership](https://en.wikipedia.org/wiki/Code_ownership).

A task can have an owner. The idea is that the owner is responsible for the task to be implemented and can be contacted for questions or issues related to the task.

This does not mean that the owner has to be the only person working on the task. They can utilize any help the need to achive the desired result, be other tools or other persons, often in different roles. For example, the owner might be a developer, but they get or recruit outside help from a requirements engineer, a software architect, a fellow developer reviewing the code, and a quality engineer who helps with testing. All these people contribute work to the task. Ultimately, though, it is the owners' responsibility to ensure that work by others contributes towards the goal of the task.

## Automatic ownership

For now, Siisurit uses a simple approach to automatically assign an owner to a task. The first condition yielding an owner sticks:

1. If people contributed work to the task, the person contributing the most is the owner.
2. If the task has a single assignee, it is the owner.
3. If the task has multiple assignees, the assignee known to Siisurit the longest is the owner. Technically, this is the member with the smallest user ID.
4. If the task has estimates by a specific member, this is the owner. If there are multiple members estimating the task, the member with the smallest user ID is the owner.

## Manual ownership

Some trackers support assigning an owner to a task.

!!! info "This has yet to be implemented."
