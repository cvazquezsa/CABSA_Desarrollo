[Forma]
Clave=TablaImpuesto
Nombre=Tablas de Impuestos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=475
PosicionInicialArriba=362
PosicionInicialAltura=300
PosicionInicialAncho=329
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=273

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TablaImpuesto
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
OtroOrden=S
ListaOrden=(Lista)

[Lista.TablaImpuesto.TablaImpuesto]
Carpeta=Lista
Clave=TablaImpuesto.TablaImpuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaImpuesto.PeriodoTipo]
Carpeta=Lista
Clave=TablaImpuesto.PeriodoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
TablaImpuesto=158
PeriodoTipo=141

[Acciones.Editar]
Nombre=Editar
Boton=47
NombreDesplegar=E&ditar Tabla
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TablaImpuestoD
Activo=S
ConCondicion=S
Antes=S
Visible=S
NombreEnBoton=S
EjecucionCondicion=ConDatos(TablaImpuesto:TablaImpuesto.TablaImpuesto) y ConDatos(TablaImpuesto:TablaImpuesto.PeriodoTipo)
AntesExpresiones=Asigna(Info.Tabla, TablaImpuesto:TablaImpuesto.TablaImpuesto)<BR>Asigna(Info.PeriodoTipo, TablaImpuesto:TablaImpuesto.PeriodoTipo)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Editar
Editar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TablaImpuesto.TablaImpuesto
TablaImpuesto.TablaImpuesto=TablaImpuesto.PeriodoTipo
TablaImpuesto.PeriodoTipo=(Fin)

[Lista.ListaOrden]
(Inicio)=TablaImpuesto.PeriodoTipo<TAB>(Acendente)
TablaImpuesto.PeriodoTipo<TAB>(Acendente)=TablaImpuesto.TablaImpuesto<TAB>(Acendente)
TablaImpuesto.TablaImpuesto<TAB>(Acendente)=(Fin)
