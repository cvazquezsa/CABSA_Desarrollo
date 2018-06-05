[Forma]
Clave=EmpresaCfgCxpTasa
Nombre=<T>Tasas Diarias de Interes (Cxp)<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=385
PosicionInicialArriba=340
PosicionInicialAltura=115
PosicionInicialAncho=300
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

[Ficha.EmpresaCfg.CxpProntoPagoTasa]
Carpeta=Ficha
Clave=EmpresaCfg.CxpProntoPagoTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.EmpresaCfg.CxpMoratoriosTasa]
Carpeta=Ficha
Clave=EmpresaCfg.CxpMoratoriosTasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ListaEnCaptura]
(Inicio)=EmpresaCfg.CxpProntoPagoTasa
EmpresaCfg.CxpProntoPagoTasa=EmpresaCfg.CxpMoratoriosTasa
EmpresaCfg.CxpMoratoriosTasa=(Fin)
