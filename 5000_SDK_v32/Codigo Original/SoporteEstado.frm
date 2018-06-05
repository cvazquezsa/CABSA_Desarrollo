[Forma]
Clave=SoporteEstado
Nombre=Estados de Soporte/Reportes
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=303
PosicionInicialArriba=234
PosicionInicialAltura=300
PosicionInicialAncho=417
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SoporteEstado
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.SoporteEstado.Estado]
Carpeta=Lista
Clave=SoporteEstado.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
Orden=38
Estado=196
NombrePlural=191

[Lista.SoporteEstado.NombrePlural]
Carpeta=Lista
Clave=SoporteEstado.NombrePlural
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

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
AntesExpresiones=Forma(<T>SoporteEstadoOrdenar<T>)
DespuesGuardar=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Ordenar
Ordenar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SoporteEstado.Estado
SoporteEstado.Estado=SoporteEstado.NombrePlural
SoporteEstado.NombrePlural=(Fin)
