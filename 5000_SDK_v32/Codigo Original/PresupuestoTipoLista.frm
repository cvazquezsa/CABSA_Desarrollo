[Forma]
Clave=PresupuestoTipoLista
Nombre=Tipos de Presupuestos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=398
PosicionInicialArriba=230
PosicionInicialAltura=301
PosicionInicialAncho=229
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=274

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PresupuestoTipo
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=PresupuestoTipo.Tipo
CarpetaVisible=S
MenuLocal=S
ListaAcciones=Actualizar

[Lista.PresupuestoTipo.Tipo]
Carpeta=Lista
Clave=PresupuestoTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Presupuesto]
Nombre=Presupuesto
Boton=64
NombreEnBoton=S
NombreDesplegar=&Presupuesto
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Antes=
Expresion=Asigna(Info.Tipo, PresupuestoTipo:PresupuestoTipo.Tipo)<BR>SI(Info.VerAcum, Forma(<T>PresupuestoAcum<T>), Forma(<T>Presupuesto<T>))

[Lista.Columnas]
Tipo=200

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Presupuesto
Presupuesto=(Fin)
