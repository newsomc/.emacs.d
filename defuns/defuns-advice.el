(defadvice jao-toggle-selective-display (after malko/toggle-center activate)
  (recenter))
