(module
    (import "js" "mem" (memory 1))
    (func $zero (param $offset i32) (param $count i32)
        get_local $offset

        i32.const 4
        get_local $count
        i32.mul
        i32.add
        set_local $count

        (block $zeroLoop
            (loop 
                (br_if $zeroLoop (i32.eq (get_local $offset) (get_local $count)))

                (get_local $offset)
                (i64.const 0)
                (i64.store)

                (i32.add (i32.const 4) (get_local $offset)) ;; offset += 4
                (set_local $offset)
                (br 0) ;; This jumps to the top of the loop again.  Why??? IDK... The other br jumps to the end
            )
        )
    )
    (func $seive (param $maxPrime i32)
        ;; This isn't needed because javascript already zeros out the block
        ;; (call $zero (i32.const 0) (get_local $maxPrime))
        (local $multiplier i32)
        (local $idx i32)
        (local $result i32)
        (local $offset i32)
        (set_local $multiplier (i32.const 2))
        (set_local $result (i32.const 0))
        (set_local $idx (i32.const 2))

        (block $seiveLoop
            (loop
                (br_if $seiveLoop (i32.gt_u (get_local $idx) (get_local $maxPrime)))

                (set_local $multiplier (i32.const 1))

                (set_local $offset (i32.mul (get_local $idx) (i32.const 4)))
                (if (i32.load (get_local $offset)) 
                    (then) 
                    (else 
                        (i32.store (get_local $offset) (i32.const 1))

                        (block (loop 
                            (set_local $result (i32.mul (get_local $multiplier) (get_local $idx))) 
                            (br_if 1 (i32.gt_u (get_local $result) (get_local $maxPrime)))
                            
                            ;; If we're here, result is less than maxPrime
                            (set_local $offset (i32.mul (get_local $result) (i32.const 4)))

                            (if (i32.load (get_local $offset)) 
                                (then) 
                                (else
                                    (i32.store (get_local $offset) (i32.const 2))
                                )
                            )

                            ;; multiplier += 1
                            (i32.add (i32.const 1) (get_local $multiplier))
                            set_local $multiplier
                        
                            (br 0)
                        ))
                    )
                )

                (i32.add (i32.const 1) (get_local $idx))
                set_local $idx ;; idx += 1
                (br 0)
            )
        ) 

        (block $organizer
            (set_local $idx (i32.const 4))
            (set_local $offset (i32.const 4))
            (loop 
                (br_if 1 (i32.eq (get_local $offset) (i32.mul (get_local $maxPrime) (i32.const 4))))

                (if (i32.eq (i32.load (get_local $offset)) (i32.const 1)) 
                    (then 

                    (i32.store (get_local $idx) (i32.div_u (get_local $offset) (i32.const 4)))

                    (i32.add (get_local $idx) (i32.const 4))
                    (set_local $idx)
                    )
                ) 

                (i32.add (get_local $offset) (i32.const 4))
                (set_local $offset)

                (br 0)
            )
        )

        (i32.store (i32.const 0) (i32.div_u (get_local $idx) (i32.const 4)))
    )
    (export "seive" (func $seive))
)