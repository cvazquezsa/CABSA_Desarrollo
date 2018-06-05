
[Forma]
Clave=MovTipoMFADocConciliado
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Movimiento por Fecha Conciliación
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
BarraHerramientas=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=511
PosicionInicialArriba=208
PosicionInicialAlturaCliente=273
PosicionInicialAncho=343
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoMFADocConciliado
Fuente={Tahoma, 8, Negro, []}
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
[Lista.ListaEnCaptura]
(Inicio)=MovTipoMFADocConciliado.Modulo
MovTipoMFADocConciliado.Modulo=MovTipoMFADocConciliado.Mov
MovTipoMFADocConciliado.Mov=(Fin)

[Lista.MovTipoMFADocConciliado.Modulo]
Carpeta=Lista
Clave=MovTipoMFADocConciliado.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.MovTipoMFADocConciliado.Mov]
Carpeta=Lista
Clave=MovTipoMFADocConciliado.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Modulo=61
Mov=182
