[Forma]
Clave=VINMov
Nombre=<T>Especificar VIN<T>
Icono=5
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=443
PosicionInicialArriba=368
PosicionInicialAltura=243
PosicionInicialAncho=393
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionSeccion1=48
VentanaEscCerrar=S
BarraAcciones=S
AccionesDivision=S
AccionesDerecha=S
PosicionInicialAlturaCliente=260
ExpresionesAlMostrar=Asigna(Info.Propiedades, Nulo)

[Lista]
Estilo=Ficha
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VINMov
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
FiltroGeneral=VINMov.Empresa   = <T>{Empresa}<T>       AND<BR>VINMov.Modulo    = <T>{Info.Modulo}<T>   AND<BR>VINMov.ID        = {Info.ID}         AND<BR>VINMov.RenglonID = {Info.RenglonID}  AND<BR>VINMov.Articulo  = <T>{Info.Articulo}<T> AND<BR>VINMov.SubCuenta = <T>{Info.SubCuenta}<T>

[Lista.VINMov.SerieLote]
Carpeta=Lista
Clave=VINMov.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
IgnoraFlujo=N
Efectos=[Negritas]

[Lista.Columnas]
SerieLote=153
Propiedades=124
Cantidad=60
CantidadAlterna=59
Cliente=68
Localizacion=65

[Acciones.SerieLoteInfo]
Nombre=SerieLoteInfo
Boton=34
NombreDesplegar=&Información
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=SerieLoteInfo
Activo=S
Visible=S
EspacioPrevio=S
Antes=S
NombreEnBoton=S
EnBarraAcciones=S
AntesExpresiones=Asigna(Info.SerieLote, VINMov:VINMov.SerieLote)

[Acciones.Eliminar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
Visible=S
EnBarraAcciones=S
Multiple=S
ListaAccionesMultiples=Aceptar
GuardarAntes=S
EjecucionCondicion=Asigna(Info.VIN, VINMov:VINMov.SerieLote)<BR>ConDatos(VINMov:VINMov.SerieLote)

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=Cancelar
Multiple=S
EnBarraHerramientas=S
TipoAccion=Ventana
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S
EnBarraAcciones=S

[Lista.VIN.Articulo]
Carpeta=Lista
Clave=VIN.Articulo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Lista.VIN.Motor]
Carpeta=Lista
Clave=VIN.Motor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Lista.VIN.Llave]
Carpeta=Lista
Clave=VIN.Llave
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Lista.VIN.Aduana]
Carpeta=Lista
Clave=VIN.Aduana
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Lista.VIN.Pedimento]
Carpeta=Lista
Clave=VIN.Pedimento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Lista.VIN.Fecha]
Carpeta=Lista
Clave=VIN.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Lista.VIN.ClaveVehicular]
Carpeta=Lista
Clave=VIN.ClaveVehicular
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Lista.VIN.NumeroEconomico]
Carpeta=Lista
Clave=VIN.NumeroEconomico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Lista.VIN.Placas]
Carpeta=Lista
Clave=VIN.Placas
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=SerieLoteInfo
SerieLoteInfo=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VINMov.SerieLote
VINMov.SerieLote=VIN.Articulo
VIN.Articulo=VIN.Motor
VIN.Motor=VIN.Llave
VIN.Llave=VIN.Aduana
VIN.Aduana=VIN.Pedimento
VIN.Pedimento=VIN.Fecha
VIN.Fecha=VIN.ClaveVehicular
VIN.ClaveVehicular=VIN.NumeroEconomico
VIN.NumeroEconomico=VIN.Placas
VIN.Placas=(Fin)
