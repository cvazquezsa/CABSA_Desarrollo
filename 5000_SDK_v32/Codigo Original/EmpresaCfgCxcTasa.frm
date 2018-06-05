[Forma]
Clave=EmpresaCfgCxcTasa
Nombre=<T>Tasas Diarias de Interes (Cxc)<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=361
PosicionInicialArriba=309
PosicionInicialAltura=150
PosicionInicialAncho=302
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
Comentarios=Empresa

[Ficha]
Estilo=Ficha
Clave=Ficha
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgTasa
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PermiteEditar=S
PestanaNombre=Cuentar por Cobrar
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
FiltroGeneral=EmpresaCfg.Empresa=<T>{Empresa}<T>

[Ficha.EmpresaCfg.CxcMoratoriosTasa]
Carpeta=Ficha
Clave=EmpresaCfg.CxcMoratoriosTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.EmpresaCfg.CxcRefinanciamientoTasa]
Carpeta=Ficha
Clave=EmpresaCfg.CxcRefinanciamientoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

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

[Ficha.EmpresaCfg.CxcProntoPagoTasa]
Carpeta=Ficha
Clave=EmpresaCfg.CxcProntoPagoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ListaEnCaptura]
(Inicio)=EmpresaCfg.CxcProntoPagoTasa
EmpresaCfg.CxcProntoPagoTasa=EmpresaCfg.CxcMoratoriosTasa
EmpresaCfg.CxcMoratoriosTasa=EmpresaCfg.CxcRefinanciamientoTasa
EmpresaCfg.CxcRefinanciamientoTasa=(Fin)
