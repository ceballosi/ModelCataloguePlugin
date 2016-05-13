dataModel name: 'SI', {
    // the units are already there but unclassified
    globalSearchFor measurementUnit

    id 'http://www.bipm.org/en/publications/si-brochure/'
    description 'The International System of Units (SI)'


    measurementUnit name: 'meter', symbol: 'm', {
        id 'http://www.bipm.org/en/publications/si-brochure/metre.html'
        description '''
            The 1889 definition of the metre, based on the international prototype of platinum-iridium, was replaced by the 11th CGPM (1960) using a definition based on the wavelength of krypton 86 radiation. This change was adopted in order to improve the accuracy with which the definition of the metre could be realized, the realization being achieved using an interferometer with a travelling microscope to measure the optical path difference as the fringes were counted. In turn, this was replaced in 1983 by the 17th CGPM (1983, Resolution 1) that specified the current definition, as follows:

            The metre is the length of the path travelled by light in vacuum during a time interval of 1/299 792 458 of a second.

            It follows that the speed of light in vacuum is exactly 299 792 458 metres per second, c0 = 299 792 458 m/s.

            The original international prototype of the metre, which was sanctioned by the 1st CGPM in 1889, is still kept at the BIPM under conditions specified in 1889.
        '''
    }

    measurementUnit name: 'kilogram', symbol: 'kg', {
        id 'http://www.bipm.org/en/publications/si-brochure/kilogram.html'
        description '''
            The international prototype of the kilogram, an artefact made of platinum-iridium, is kept at the BIPM under the conditions specified by the 1st CGPM in 1889 when it sanctioned the prototype and declared:

            This prototype shall henceforth be considered to be the unit of mass.
            The 3rd CGPM (1901), in a declaration intended to end the ambiguity in popular usage concerning the use of the word "weight", confirmed that:

            The kilogram is the unit of mass; it is equal to the mass of the international prototype of the kilogram.
            The complete declaration appears here.

            It follows that the mass of the international prototype of the kilogram is always 1 kilogram exactly, m(grand K) = 1 kg. However, due to the inevitable accumulation of contaminants on surfaces, the international prototype is subject to reversible surface contamination that approaches 1 µg per year in mass. For this reason, the CIPM declared that, pending further research, the reference mass of the international prototype is that immediately after cleaning and washing by a specified method (PV, 1989, 57, 104-105 and PV, 1990, 58, 95-97). The reference mass thus defined is used to calibrate national standards of platinum-iridium alloy (Metrologia, 1994, 31, 317-336).
        '''
    }

    measurementUnit name: 'second', symbol: 's', {
        id 'http://www.bipm.org/en/publications/si-brochure/second.html'
        description '''
            The unit of time, the second, was at one time considered to be the fraction 1/86 400 of the mean solar day. The exact definition of "mean solar day" was left to the astronomers. However measurements showed that irregularities in the rotation of the Earth made this an unsatisfactory definition. In order to define the unit of time more precisely, the 11th CGPM (1960, Resolution 9) adopted a definition given by the International Astronomical Union based on the tropical year 1900. Experimental work, however, had already shown that an atomic standard of time, based on a transition between two energy levels of an atom or a molecule, could be realized and reproduced much more accurately. Considering that a very precise definition of the unit of time is indispensable for science and technology, the 13th CGPM (1967/68, Resolution 1) replaced the definition of the second by the following:

            The second is the duration of 9 192 631 770 periods of the radiation corresponding to the transition between the two hyperfine levels of the ground state of the caesium 133 atom.
            It follows that the hyperfine splitting in the ground state of the caesium 133 atom is exactly 9 192 631 770 hertz, nu(hfs Cs) = 9 192 631 770 Hz.

            At its 1997 meeting the CIPM affirmed that:

            This definition refers to a caesium atom at rest at a temperature of 0 K.
            This note was intended to make it clear that the definition of the SI second is based on a caesium atom unperturbed by black body radiation, that is, in an environment whose thermodynamic temperature is 0 K. The frequencies of all primary frequency standards should therefore be corrected for the shift due to ambient radiation, as stated at the meeting of the Consultative Committee for Time and Frequency in 1999.
        '''
    }

    measurementUnit name: 'ampere', symbol: 'A', {
        id 'http://www.bipm.org/en/publications/si-brochure/ampere.html'
        description '''
            Electric units, called "international units", for current and resistance, were introduced by the International Electrical Congress held in Chicago in 1893, and definitions of the "international ampere" and "international ohm" were confirmed by the International Conference in London in 1908.

            Although it was already obvious on the occasion of the 8th CGPM (1933) that there was a unanimous desire to replace those "international units" by so-called "absolute units", the official decision to abolish them was only taken by the 9th CGPM (1948), which adopted the ampere for the unit of electric current, following a definition proposed by the CIPM (1946, Resolution 2):

            The ampere is that constant current which, if maintained in two straight parallel conductors of infinite length, of negligible circular cross-section, and placed 1 metre apart in vacuum, would produce between these conductors a force equal to 2 x 10–7 newton per metre of length.
            It follows that the magnetic constant, mu0, also known as the permeability of free space, is exactly 4 x 10–7 henries per metre, mu0 = 4 x 10–7 H/m.

            The expression "MKS unit of force" which occurs in the original text of 1946 has been replaced here by "newton", a name adopted for this unit by the 9th CGPM (1948, Resolution 7).
        '''
    }

    measurementUnit name: 'kelvin', symbol: 'K', {
        id 'http://www.bipm.org/en/publications/si-brochure/kelvin.html'
        description '''
            The kelvin, unit of thermodynamic temperature, is the fraction 1/273.16 of the thermodynamic temperature of the triple point of water.
            It follows that the thermodynamic temperature of the triple point of water is exactly 273.16 kelvins, Ttpw = 273.16 K.

            The symbol, Ttpw, is used to denote the thermodynamic temperature of the triple point of water.
            At its 2005 meeting the CIPM affirmed that:

            This definition refers to water having the isotopic composition defined exactly by the following amount of substance ratios: 0.000 155 76 mole of 2H per mole of 1H, 0.000 379 9 mole of 17O per mole of 16O, and 0.002 005 2 mole of 18O per mole of 16O.
            Because of the manner in which temperature scales used to be defined, it remains common practice to express a thermodynamic temperature, symbol T, in terms of its difference from the reference temperature T0 = 273.15 K, the ice point. This difference is called the Celsius temperature, symbol t, which is defined by the quantity equation:

            t = T – T0.
            The unit of Celsius temperature is the degree Celsius, symbol °C, which is by definition equal in magnitude to the kelvin. A difference or interval of temperature may be expressed in kelvins or in degrees Celsius (13th CGPM, 1967/68, Resolution 3, mentioned above), the numerical value of the temperature difference being the same. However, the numerical value of a Celsius temperature expressed in degrees Celsius is related to the numerical value of the thermodynamic temperature expressed in kelvins by the relation

            t/°C = T/K – 273.15.
        '''
    }

    measurementUnit name: 'mole', symbol: 'mol', {
        id 'http://www.bipm.org/en/publications/si-brochure/mole.html'
        description '''
            The quantity used by chemists to specify the amount of chemical elements or compounds is now called "amount of substance". Amount of substance is defined to be proportional to the number of specified elementary entities in a sample, the proportionality constant being a universal constant which is the same for all samples. The unit of amount of substance is called the mole, symbol mol, and the mole is defined by specifying the mass of carbon 12 that constitutes one mole of carbon 12 atoms. By international agreement this was fixed at 0.012 kg, i.e. 12 g.

            Following proposals by the IUPAP, the IUPAC, and the ISO, the CIPM gave a definition of the mole in 1967 and confirmed it in 1969. This was adopted by the 14th CGPM (1971, Resolution 3):

            The mole is the amount of substance of a system which contains as many elementary entities as there are atoms in 0.012 kilogram of carbon 12; its symbol is "mol".
            When the mole is used, the elementary entities must be specified and may be atoms, molecules, ions, electrons, other particles, or specified groups of such particles.
            It follows that the molar mass of carbon 12 is exactly 12 grams per mole, M(12C) = 12 g/mol.

            In 1980 the CIPM approved the report of the CCU (1980) which specified that

            In this definition, it is understood that unbound atoms of carbon 12, at rest and in their ground state, are referred to.
            The definition of the mole also determines the value of the universal constant that relates the number of entities to amount of substance for any sample. This constant is called the Avogadro constant, symbol NA or L. If N(X) denotes the number of entities X in a specified sample, and if n(X) denotes the amount of substance of entities X in the same sample, the relation is

            n(X) = N(X)/NA.
            Note that since N(X) is dimensionless, and n(X) has the SI unit mole, the Avogadro constant has the coherent SI unit reciprocal mole.
        '''
    }

    measurementUnit name: 'candela', symbol: 'cd', {
        id 'http://www.bipm.org/en/publications/si-brochure/candela.html'
        description '''
            The units of luminous intensity based on flame or incandescent filament standards in use in various countries before 1948 were replaced initially by the "new candle" based on the luminance of a Planck radiator (a black body) at the temperature of freezing platinum. This modification had been prepared by the International Commission on Illumination (CIE) and by the CIPM before 1937, and the decision was promulgated by the CIPM in 1946. It was then ratified in 1948 by the 9th CGPM which adopted a new international name for this unit, the candela, symbol cd; in 1967 the 13th CGPM (Resolution 5) gave an amended version of this definition.

            In 1979, because of the difficulties in realizing a Planck radiator at high temperatures, and the new possibilities offered by radiometry, i.e. the measurement of optical radiation power, the 16th CGPM (1979, Resolution 3) adopted a new definition of the candela:

            The candela is the luminous intensity, in a given direction, of a source that emits monochromatic radiation of frequency 540 x 1012 hertz and that has a radiant intensity in that direction of 1/683 watt per steradian.
            It follows that the spectral luminous efficacy for monochromatic radiation of frequency of 540 x 1012 hertz is exactly 683 lumens per watt, K = 683 lm/W = 683 cd sr/W.
            Note that since N(X) is dimensionless, and n(X) has the SI unit mole, the Avogadro constant has the coherent SI unit reciprocal mole.
        '''
    }


}

dataModel name: 'SI Derived Units', {

// the units are already there but unclassified
globalSearchFor measurementUnit
description 'The International System of Units (SI) Derived Units'

rel 'import' to "SI", "SI"

// other units, unclassified
measurementUnit name: 'area', description: 'square meter', symbol: 'm2', {
    rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'volume', description: 'cubic meter', symbol: 'm3',{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'speed, velocity', description: 'meter per second', symbol: 'm/s',{
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'acceleration', description: 'meter per second squared  ', symbol: 'm/s2',{
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'wave number', description: 'reciprocal meter', symbol: 'm-1',{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'mass density', description: 'kilogram per cubic meter', symbol: 'kg/m3',{
rel "relatedTo" to "SI", "meter"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'surface density', description: 'kilogram per square metre', symbol: 'kg/m2',{
rel "relatedTo" to "SI", "meter"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'specific volume', description: 'cubic meter per kilogram', symbol: 'm3/kg',{
rel "relatedTo" to "SI", "meter"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'current density', description: 'ampere per square meter', symbol: 'A/m2',{
rel "relatedTo" to "SI", "ampere"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'magnetic field strength  ', description: 'ampere per meter', symbol: 'A/m',{
rel "relatedTo" to "SI", "meter"
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: 'amount-of-substance concentration', description: 'mole per cubic meter', symbol: 'mol/m3',{
rel "relatedTo" to "SI", "mole"
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: 'luminance', description: 'candela per square meter', symbol: 'cd/m2',{
rel "relatedTo" to "SI", "meter"
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: 'mass fraction', description: 'kilogram per kilogram', symbol: 'kg/kg = 1',{
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'plane angle', description:'radian (a)  (m·m-1 = 1 (b))', symbol: 'rad',{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'solid angle', description:'steradian (a)  (m2·m-2 = 1 (b))', symbol: 'sr (c)',{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'frequency', description:'hertz  (s-1)', symbol: 'Hz',{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: 'force', description:'newton  (m·kg·s-2)', symbol: 'N',{
rel "relatedTo" to "SI", "meter"
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'pressure, stress', description:'pascal  (m-1·kg·s-2)', symbol: 'Pa',{
rel "relatedTo" to "SI", "meter"
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'energy, work, quantity of heat', description:'joule  (m2·kg·s-2)', symbol: 'J',{
rel "relatedTo" to "SI", "meter"
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'power, radiant flux', description:'watt  (m2·kg·s-3)', symbol: 'W',{
rel "relatedTo" to "SI", "meter"
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'electric charge, quantity of electricity', description:'coulomb  (s·A)', symbol: 'C',{
rel "relatedTo" to "SI", "ampere"
rel "relatedTo" to "SI", "second"
}
measurementUnit name: 'electromotive force', description:'volt  (m2·kg·s-3·A-1)', symbol: 'V',{
rel "relatedTo" to "SI", "ampere"
rel "relatedTo" to "SI", "meter"
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'capacitance', description:'farad  (m-2·kg-1·s4·A2)', symbol: 'F',{
rel "relatedTo" to "SI", "ampere"
rel "relatedTo" to "SI", "meter"
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'electric resistance', description:'ohm  (m2·kg·s-3·A-2)', symbol: 'Omega',{
rel "relatedTo" to "SI", "ampere"
rel "relatedTo" to "SI", "meter"
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'electric conductance', description:'siemens  (m-2·kg-1·s3·A2)', symbol: 'S',{
rel "relatedTo" to "SI", "ampere"
rel "relatedTo" to "SI", "meter"
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'magnetic flux', description:'weber  (m2·kg·s-2·A-1)', symbol: 'Wb',{
rel "relatedTo" to "SI", "ampere"
rel "relatedTo" to "SI", "meter"
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'magnetic flux density', description:'tesla  (kg·s-2·A-1)', symbol: 'T',{
rel "relatedTo" to "SI", "ampere"
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'inductance', description:'henry  (m2·kg·s-2·A-2)', symbol: 'H',{
rel "relatedTo" to "SI", "ampere"
rel "relatedTo" to "SI", "meter"
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'Celsius temperature', description:'degree Celsius  (K)', symbol: '°C',{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: 'luminous flux', description:'lumen  (m2·m-2·cd = cd)', symbol: 'lm',{
rel "relatedTo" to "SI", "candela"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'illuminance', description:'lux  (m2·m-4·cd = m-2·cd)', symbol: 'lx',{
rel "relatedTo" to "SI", "candela"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'activity (of a radionuclide)', description:'becquerel  (s-1)', symbol: 'Bq',{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: 'absorbed dose, specific energy (imparted), kerma', description:'gray  (m2·s-2)', symbol: 'Gy',{
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'dose equivalent (d)', description:'sievert  (m2·s-2)', symbol: 'Sv',{
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'catalytic activity', description:'katal  (s-1·mol)', symbol: 'kat',{
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'dynamic viscosity', description:'pascal second ', symbol: 'Pa·s',{
rel "relatedTo" to "SI", "second"
rel "relatedTo" to "pascal"
}
measurementUnit name: 'moment of force', description:'newton meter  ', symbol: 'N·m',{
rel "relatedTo" to "force"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'surface tension', description:'newton per meter  ', symbol: 'N/m',{
rel "relatedTo" to "force"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'angular velocity', description:'radian per second  ', symbol: 'rad/s',{
rel "relatedTo" to "plane angle"
rel "relatedTo" to "SI", "second"
}
measurementUnit name: 'angular acceleration', description:'radian per second squared  ', symbol: 'rad/s2',{
rel "relatedTo" to "plane angle"
rel "relatedTo" to "SI", "second"
}
measurementUnit name: 'heat flux density, irradiance', description:'watt per square meter ', symbol: 'W/m2',{
rel "relatedTo" to "power, radiant flux"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'heat capacity, entropy', description:'joule per kelvin  ', symbol: 'J/K',{
rel "relatedTo" to "energy, work, quantity of heat"
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: 'specific heat capacity, specific entropy', description:'joule per kilogram kelvin  ()', symbol: 'J/(kg·K)',{
rel "relatedTo" to "energy, work, quantity of heat"
rel "relatedTo" to "SI", "kelvin"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'specific energy', description:'joule per kilogram  ', symbol: 'J/kg',{
rel "relatedTo" to "energy, work, quantity of heat"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'thermal conductivity', description:'watt per meter kelvin  ', symbol: 'W/(m·K)',{
rel "relatedTo" to "power, radiant flux"
rel "relatedTo" to "SI", "kelvin"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'energy density', description:'joule per cubic meter  ', symbol: 'J/m3',{
rel "relatedTo" to "energy, work, quantity of heat"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'electric field strength', description:'volt per meter  ', symbol: 'V/m',{
rel "relatedTo" to "electromotive force"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'electric charge density', description:'coulomb per cubic meter ', symbol: 'C/m3',{
rel "relatedTo" to "electric charge, quantity of electricity"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'electric flux density', description:'coulomb per square meter  ', symbol: 'C/m2',{
rel "relatedTo" to "electric charge, quantity of electricity"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'permittivity', description:'farad per meter  ', symbol: 'F/m',{
rel "relatedTo" to "capacitance"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'permeability', description:'henry per meter  ', symbol: 'H/m',{
rel "relatedTo" to "inductance"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'molar energy', description:'joule per mole  ', symbol: 'J/mol',{
rel "relatedTo" to "energy, work, quantity of heat"
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: 'molar entropy, molar heat capacity', description:'joule per mole kelvin  ()', symbol: 'J/(mol·K)',{
rel "relatedTo" to "energy, work, quantity of heat"
rel "relatedTo" to "SI", "mole"
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: 'exposure (x and gamma rays)', description:'coulomb per kilogram  ()', symbol: 'C/kg',{
rel "relatedTo" to "electric charge, quantity of electricity"
rel "relatedTo" to "SI", "kilogram"
}
measurementUnit name: 'absorbed dose rate', description:'gray per second  ', symbol: 'Gy/s',{
rel "relatedTo" to "absorbed dose, specific energy (imparted), kerma"
rel "relatedTo" to "SI", "second"
}
measurementUnit name: 'radiant intensity', description:'watt per steradian  ', symbol: 'W/sr',{
rel "relatedTo" to "power, radiant flux"
rel "relatedTo" to "solid angle"
}
measurementUnit name: 'radiance', description:'watt per square meter steradian  ', symbol: 'W/(m2·sr)',{
rel "relatedTo" to "power, radiant flux"
rel "relatedTo" to "solid angle"
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: 'catalytic (activity) concentration', description:'katal per cubic meter ', symbol: 'kat/m3',{
rel "relatedTo" to "catalytic activity"
rel "relatedTo" to "SI", "meter"
}

measurementUnit name: "fahrenheit", description: "degrees fahrenheit (K)", symbol: "°F",{
rel "relatedTo" to "kelvin"
}

measurementUnit name: "yottaampere", description: "ampere*10^24", symbol: "YA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "zettaampere", description: "ampere*10^21", symbol: "ZA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "exaampere", description: "ampere*10^18", symbol: "EA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "petaampere", description: "ampere*10^15", symbol: "PA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "teraampere", description: "ampere*10^12", symbol: "TA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "gigaampere", description: "ampere*10^9", symbol: "GA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "megaampere", description: "ampere*10^6", symbol: "MA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "kiloampere", description: "ampere*10^3", symbol: "kA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "hectoampere", description: "ampere*10^2", symbol: "hA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "dekaampere", description: "ampere*10^1", symbol: "daA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "deciampere", description: "ampere*10^-1", symbol: "dA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "centiampere", description: "ampere*10^-2", symbol: "cA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "milliampere", description: "ampere*10^-3", symbol: "mA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "microampere", description: "ampere*10^-6", symbol: "µA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "nanoampere", description: "ampere*10^-9", symbol: "nA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "picoampere", description: "ampere*10^-12", symbol: "pA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "femtoampere", description: "ampere*10^-15", symbol: "fA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "attoampere", description: "ampere*10^-18", symbol: "aA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "zeptoampere", description: "ampere*10^-21", symbol: "zA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "yoctoampere", description: "ampere*10^-24", symbol: "yA" ,{
rel "relatedTo" to "SI", "ampere"
}
measurementUnit name: "yottacandela", description: "candela*10^24", symbol: "Ycd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "zettacandela", description: "candela*10^21", symbol: "Zcd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "exacandela", description: "candela*10^18", symbol: "Ecd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "petacandela", description: "candela*10^15", symbol: "Pcd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "teracandela", description: "candela*10^12", symbol: "Tcd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "gigacandela", description: "candela*10^9", symbol: "Gcd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "megacandela", description: "candela*10^6", symbol: "Mcd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "kilocandela", description: "candela*10^3", symbol: "kcd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "hectocandela", description: "candela*10^2", symbol: "hcd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "dekacandela", description: "candela*10^1", symbol: "dacd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "decicandela", description: "candela*10^-1", symbol: "dcd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "centicandela", description: "candela*10^-2", symbol: "ccd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "millicandela", description: "candela*10^-3", symbol: "mcd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "microcandela", description: "candela*10^-6", symbol: "µcd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "nanocandela", description: "candela*10^-9", symbol: "ncd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "picocandela", description: "candela*10^-12", symbol: "pcd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "femtocandela", description: "candela*10^-15", symbol: "fcd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "attocandela", description: "candela*10^-18", symbol: "acd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "zeptocandela", description: "candela*10^-21", symbol: "zcd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "yoctocandela", description: "candela*10^-24", symbol: "ycd" ,{
rel "relatedTo" to "SI", "candela"
}
measurementUnit name: "yottakelvin", description: "kelvin*10^24", symbol: "YK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "zettakelvin", description: "kelvin*10^21", symbol: "ZK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "exakelvin", description: "kelvin*10^18", symbol: "EK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "petakelvin", description: "kelvin*10^15", symbol: "PK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "terakelvin", description: "kelvin*10^12", symbol: "TK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "gigakelvin", description: "kelvin*10^9", symbol: "GK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "megakelvin", description: "kelvin*10^6", symbol: "MK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "kilokelvin", description: "kelvin*10^3", symbol: "kK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "hectokelvin", description: "kelvin*10^2", symbol: "hK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "dekakelvin", description: "kelvin*10^1", symbol: "daK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "decikelvin", description: "kelvin*10^-1", symbol: "dK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "centikelvin", description: "kelvin*10^-2", symbol: "cK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "millikelvin", description: "kelvin*10^-3", symbol: "mK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "microkelvin", description: "kelvin*10^-6", symbol: "µK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "nanokelvin", description: "kelvin*10^-9", symbol: "nK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "picokelvin", description: "kelvin*10^-12", symbol: "pK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "femtokelvin", description: "kelvin*10^-15", symbol: "fK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "attokelvin", description: "kelvin*10^-18", symbol: "aK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "zeptokelvin", description: "kelvin*10^-21", symbol: "zK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "yoctokelvin", description: "kelvin*10^-24", symbol: "yK" ,{
rel "relatedTo" to "SI", "kelvin"
}
measurementUnit name: "yottagram", description: "gram*10^24", symbol: "Yg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "zettagram", description: "gram*10^21", symbol: "Zg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "exagram", description: "gram*10^18", symbol: "Eg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "petagram", description: "gram*10^15", symbol: "Pg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "teragram", description: "gram*10^12", symbol: "Tg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "gigagram", description: "gram*10^9", symbol: "Gg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "megagram", description: "gram*10^6", symbol: "Mg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "hectogram", description: "gram*10^2", symbol: "hg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "dekagram", description: "gram*10^1", symbol: "dag" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "decigram", description: "gram*10^-1", symbol: "dg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "centigram", description: "gram*10^-2", symbol: "cg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "milligram", description: "gram*10^-3", symbol: "mg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "microgram", description: "gram*10^-6", symbol: "µg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "nanogram", description: "gram*10^-9", symbol: "ng" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "picogram", description: "gram*10^-12", symbol: "pg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "femtogram", description: "gram*10^-15", symbol: "fg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "attogram", description: "gram*10^-18", symbol: "ag" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "zeptogram", description: "gram*10^-21", symbol: "zg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "yoctogram", description: "gram*10^-24", symbol: "yg" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "gram", description: "kilogram*10^-3", symbol: "g" ,{
rel "relatedTo" to "SI Derived Units", "gram"
}
measurementUnit name: "yottameter", description: "meter*10^24", symbol: "Ym" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "zettameter", description: "meter*10^21", symbol: "Zm" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "exameter", description: "meter*10^18", symbol: "Em" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "petameter", description: "meter*10^15", symbol: "Pm" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "terameter", description: "meter*10^12", symbol: "Tm" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "gigameter", description: "meter*10^9", symbol: "Gm" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "megameter", description: "meter*10^6", symbol: "Mm" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "kilometer", description: "meter*10^3", symbol: "km" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "hectometer", description: "meter*10^2", symbol: "hm" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "dekameter", description: "meter*10^1", symbol: "dam" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "decimeter", description: "meter*10^-1", symbol: "dm" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "centimeter", description: "meter*10^-2", symbol: "cm" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "millimeter", description: "meter*10^-3", symbol: "mm" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "micrometer", description: "meter*10^-6", symbol: "µm" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "nanometer", description: "meter*10^-9", symbol: "nm" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "picometer", description: "meter*10^-12", symbol: "pm" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "femtometer", description: "meter*10^-15", symbol: "fm" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "attometer", description: "meter*10^-18", symbol: "am" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "zeptometer", description: "meter*10^-21", symbol: "zm" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "yoctometer", description: "meter*10^-24", symbol: "ym" ,{
rel "relatedTo" to "SI", "meter"
}
measurementUnit name: "yottamole", description: "mole*10^24", symbol: "Ymol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "zettamole", description: "mole*10^21", symbol: "Zmol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "examole", description: "mole*10^18", symbol: "Emol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "petamole", description: "mole*10^15", symbol: "Pmol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "teramole", description: "mole*10^12", symbol: "Tmol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "gigamole", description: "mole*10^9", symbol: "Gmol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "megamole", description: "mole*10^6", symbol: "Mmol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "kilomole", description: "mole*10^3", symbol: "kmol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "hectomole", description: "mole*10^2", symbol: "hmol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "dekamole", description: "mole*10^1", symbol: "damol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "decimole", description: "mole*10^-1", symbol: "dmol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "centimole", description: "mole*10^-2", symbol: "cmol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "millimole", description: "mole*10^-3", symbol: "mmol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "micromole", description: "mole*10^-6", symbol: "µmol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "nanomole", description: "mole*10^-9", symbol: "nmol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "picomole", description: "mole*10^-12", symbol: "pmol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "femtomole", description: "mole*10^-15", symbol: "fmol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "attomole", description: "mole*10^-18", symbol: "amol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "zeptomole", description: "mole*10^-21", symbol: "zmol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "yoctomole", description: "mole*10^-24", symbol: "ymol" ,{
rel "relatedTo" to "SI", "mole"
}
measurementUnit name: "yottasecond", description: "second*10^24", symbol: "Ys" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "zettasecond", description: "second*10^21", symbol: "Zs" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "exasecond", description: "second*10^18", symbol: "Es" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "petasecond", description: "second*10^15", symbol: "Ps" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "terasecond", description: "second*10^12", symbol: "Ts" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "gigasecond", description: "second*10^9", symbol: "Gs" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "megasecond", description: "second*10^6", symbol: "Ms" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "kilosecond", description: "second*10^3", symbol: "ks" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "hectosecond", description: "second*10^2", symbol: "hs" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "dekasecond", description: "second*10^1", symbol: "das" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "decisecond", description: "second*10^-1", symbol: "ds" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "centisecond", description: "second*10^-2", symbol: "cs" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "millisecond", description: "second*10^-3", symbol: "ms" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "microsecond", description: "second*10^-6", symbol: "µs" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "nanosecond", description: "second*10^-9", symbol: "ns" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "picosecond", description: "second*10^-12", symbol: "ps" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "femtosecond", description: "second*10^-15", symbol: "fs" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "attosecond", description: "second*10^-18", symbol: "as" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "zeptosecond", description: "second*10^-21", symbol: "zs" ,{
rel "relatedTo" to "SI", "second"
}
measurementUnit name: "yoctosecond", description: "second*10^-24", symbol: "ys" ,{
rel "relatedTo" to "SI", "second"
}


}



