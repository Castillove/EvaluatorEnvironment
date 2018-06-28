(*
 *[EXCEPTION] NameNotBound of string
 * An exception that is raised when a string is not not bound to a value in the
 * given Environment. 
 *)
exception NameNotBound of string;

(*
 *[TYPE] Environment = string -> int
 * A closure that maps a string to an integer.
 * This is a function type that, when given a string returns the integer
 * associated with that string. 
 *)
type Environment = string -> int;

(*
 *[FUNCTION] env_new = fn : unit -> Environment
 * Returns a new Environment.
 * Note that new Environments don't have any mappings, and as such any lookup 
 * of a string results in a "NameNotBound" exception.
 * Argument must be the unit value.
 *)
fun env_new () : Environment = fn x => raise NameNotBound "NameNotBound";

(*
 *[FUNCTION] env_lookup = fn : Environment -> string -> int
 * Returns the value associated with the given name in the given Environment. A
 * NameNotBound is thrown if the name is not bound in the Environment.
 * Arguments must be an Environment and a string.
 *)
fun env_lookup (env:Environment) name = env name;

(*
 *[FUNCTION] env_bind = fn : Environment -> string -> int -> Environment
 * Adds the given name and value mapping into the given Environment. Note that
 * such dynamic building is only possible by creating a new Environment.
 * Arguments must be an Environment, a string, and an integer.
 *)
fun env_bind (env:Environment) name value : Environment = 
    fn lookup => if name = lookup
		 then value
		 else env lookup
;
