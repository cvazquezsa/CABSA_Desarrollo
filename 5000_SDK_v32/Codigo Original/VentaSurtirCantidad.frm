[Forma]
Clave=VentaSurtirCantidad
Nombre=Cantidad
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=419
PosicionInicialArriba=334
PosicionInicialAltura=100
PosicionInicialAncho=186
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaEscCerrar=S
BarraAcciones=S
AccionesCentro=S

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
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Variables).Info.Cantidad]
Carpeta=(Variables)
Clave=Info.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=7
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.TipoCantidad]
Carpeta=(Variables)
Clave=Info.TipoCantidad
Editar=S
ValidaNombre=N
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S
EnBarraAcciones=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
EnBarraAcciones=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.Cantidad
Info.Cantidad=Info.TipoCantidad
Info.TipoCantidad=(Fin)
