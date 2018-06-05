[Forma]
Clave=TipoCuenta
Nombre=Tipos de Cuentas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialIzquierda=388
PosicionInicialArriba=242
PosicionInicialAltura=283
PosicionInicialAncho=247

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoCuenta
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

[Lista.TipoCuenta.TipoCuenta]
Carpeta=Lista
Clave=TipoCuenta.TipoCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Lista.TipoCuenta.ClaveOrden]
Carpeta=Lista
Clave=TipoCuenta.ClaveOrden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
GuardarAntes=S

[Lista.Columnas]
TipoCuenta=140
ClaveOrden=77

[Lista.ListaEnCaptura]
(Inicio)=TipoCuenta.ClaveOrden
TipoCuenta.ClaveOrden=TipoCuenta.TipoCuenta
TipoCuenta.TipoCuenta=(Fin)
