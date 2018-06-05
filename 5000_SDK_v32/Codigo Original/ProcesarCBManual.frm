[Forma]
Clave=ProcesarCBManual
Nombre=Captura Manual
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=510
PosicionInicialArriba=343
PosicionInicialAlturaCliente=304
PosicionInicialAncho=260
AccionesTamanoBoton=15x5
BarraAcciones=S
ListaAcciones=(Lista)
AccionesDivision=S
AccionesCentro=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
ExpresionesAlMostrar=Asigna(Info.Taquilla, Nulo)<BR>Asigna(Info.Folio, Nulo)<BR>Asigna(Info.AutoLocalidad, Nulo)<BR>Asigna(Info.Precio, Nulo)<BR>Asigna(Info.AutoOrigen, Nulo)<BR>Asigna(Info.AutoDestino, Nulo)<BR>Asigna(Info.Fecha, Nulo)<BR>Asigna(Info.TipoPasajero, Nulo)<BR>Asigna(Info.Corrida, Nulo)

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Variables).Info.Precio]
Carpeta=(Variables)
Clave=Info.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreDesplegar=<T>&Aceptar<T>
Multiple=S
EnBarraHerramientas=S
Activo=S
Visible=S
EnBarraAcciones=S
ListaAccionesMultiples=Variables Asignar<BR>Expresion<BR>Aceptar

[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.Clave, Info.Taquilla & <T>,<T> & Info.Folio & <T>,<T> & Info.AutoLocalidad & <T>,<T> & Info.Precio & <T>,<T> & Info.AutoOrigen & <T>,<T> & Info.AutoDestino & <T>,<T> & FechaEnTexto(Info.Fecha, <T>YYYYMMDD<T>) & <T>,<T> & Info.TipoPasajero & <T>,<T> & Info.Corrida)

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Info.Taquilla) y<BR>ConDatos(Info.Folio) y <BR>ConDatos(Info.Precio) y<BR>(SQL(<T>SELECT COUNT(*) FROM AutoLocalidad WHERE Localidad=:tLoc<T>, Info.AutoLocalidad)=1)

[(Variables).Info.Taquilla]
Carpeta=(Variables)
Clave=Info.Taquilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Folio]
Carpeta=(Variables)
Clave=Info.Folio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.AutoLocalidad]
Carpeta=(Variables)
Clave=Info.AutoLocalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Fecha]
Carpeta=(Variables)
Clave=Info.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Corrida]
Carpeta=(Variables)
Clave=Info.Corrida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.AutoOrigen]
Carpeta=(Variables)
Clave=Info.AutoOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[(Variables).Info.AutoDestino]
Carpeta=(Variables)
Clave=Info.AutoDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.TipoPasajero]
Carpeta=(Variables)
Clave=Info.TipoPasajero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.Taquilla
Info.Taquilla=Info.Folio
Info.Folio=Info.AutoLocalidad
Info.AutoLocalidad=Info.Precio
Info.Precio=Info.AutoOrigen
Info.AutoOrigen=Info.AutoDestino
Info.AutoDestino=Info.Fecha
Info.Fecha=Info.TipoPasajero
Info.TipoPasajero=Info.Corrida
Info.Corrida=(Fin)
