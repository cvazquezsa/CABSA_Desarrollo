[Forma]
Clave=NominaEliminacionParcial
Nombre=Eliminación Parcial
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=389
PosicionInicialArriba=336
PosicionInicialAltura=106
PosicionInicialAncho=246
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
PosicionInicialAlturaCliente=61
BarraHerramientas=S

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Info.Personal
CarpetaVisible=S

[(Variables).Info.Personal]
Carpeta=(Variables)
Clave=Info.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Eliminar
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S
EnBarraHerramientas=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreDesplegar=<T>&Cancelar<T>
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
EnBarraHerramientas=S
NombreEnBoton=S

[Acciones.EditarMov]
Nombre=EditarMov
Boton=47
NombreEnBoton=S
NombreDesplegar=&Pendientes
EnBarraHerramientas=S
Activo=S
Visible=S
EspacioPrevio=S
TipoAccion=Formas
Multiple=S
ListaAccionesMultiples=Variables Asignar<BR>PersonalPendientes

[Acciones.EditarMov.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.EditarMov.PersonalPendientes]
Nombre=PersonalPendientes
Boton=0
TipoAccion=Formas
ClaveAccion=PersonalPendientes
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=EditarMov
EditarMov=(Fin)
