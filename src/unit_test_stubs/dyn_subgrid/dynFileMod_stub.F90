module dynFileMod

  ! This is a stub replacement for dynFileMod. It bypasses all of the netcdf-related
  ! stuff, instead allowing direct specification of the possible set of years and the
  ! current year. Thus, it is essentially just a wrapper to a dyn_time_info variable.

  use dynTimeInfoMod, only : time_info_type, YEAR_POSITION_END_OF_TIMESTEP
  use ncdio_pio, only : file_desc_t
  implicit none
  save
  private

  public :: dyn_file_type

  ! Note that this is intended to be used with the fake form of file_desc_t, defined in
  ! ncdio_pio_fake.F90
  type, extends(file_desc_t) :: dyn_file_type
     type(time_info_type) :: time_info
  end type dyn_file_type

  interface dyn_file_type
     module procedure constructor  ! initialize a new dyn_file_type object
  end interface dyn_file_type

contains
  
  ! ======================================================================
  ! Constructors
  ! ======================================================================

  type(dyn_file_type) function constructor(my_years)
    ! Note that this should be used with the fake form of file_desc_t, defined in
    ! ncdio_pio_fake.F90
    !
    ! The time_info object is created assuming we want to use
    ! year_position=YEAR_POSITION_END_OF_TIMESTEP

    integer, intent(in) :: my_years(:)  ! all years desired for the time_info variable

    ! The following only works if we're using the fake form of file_desc_t, defined in
    ! ncdio_pio_fake.F90
    constructor%file_desc_t = file_desc_t()

    constructor%time_info = time_info_type(my_years, YEAR_POSITION_END_OF_TIMESTEP)
  end function constructor

end module dynFileMod
