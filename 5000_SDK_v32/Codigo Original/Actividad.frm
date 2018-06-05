[Forma]
Clave=Actividad
Nombre=Actividades
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=637
PosicionInicialArriba=354
PosicionInicialAltura=324
PosicionInicialAncho=655
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=456

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Actividad
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=Actividad.Orden<TAB>(Acendente)
HojaTitulos=S
HojaMostrarColumnas=S

[Lista.Actividad.Actividad]
Carpeta=Lista
Clave=Actividad.Actividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Actividad=240
Orden=38
Grupo=178
Costo=107
ModuloEsp=88

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar &Orden
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
GuardarAntes=S
DespuesGuardar=S
AntesExpresiones=Forma(<T>ActividadOrdenar<T>)

[Lista.Actividad.Grupo]
Carpeta=Lista
Clave=Actividad.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Actividad.Costo]
Carpeta=Lista
Clave=Actividad.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Actividad.ModuloEsp]
Carpeta=Lista
Clave=Actividad.ModuloEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Ordenar
Ordenar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Actividad.Actividad
Actividad.Actividad=Actividad.Grupo
Actividad.Grupo=Actividad.Costo
Actividad.Costo=Actividad.ModuloEsp
Actividad.ModuloEsp=(Fin)
