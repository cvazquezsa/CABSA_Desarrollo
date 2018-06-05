[Forma]
Clave=ConceptoPoliticaInfo
Nombre=Política del Concepto
Icono=1
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=266
PosicionInicialArriba=203
PosicionInicialAlturaCliente=584
PosicionInicialAncho=747
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
Comentarios=Info.Concepto
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ConceptoPolitica
Fuente={Tahoma, 10, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Concepto.Politica
CarpetaVisible=S
AlinearTodaCarpeta=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ConFuenteEspecial=S
PermiteEditar=S
FiltroGeneral=Concepto.Modulo=<T>{Info.Modulo}<T> AND Concepto.Concepto=<T>{Info.Concepto}<T>
CondicionEdicion=Falso

[Ficha.Concepto.Politica]
Carpeta=Ficha
Clave=Concepto.Politica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=50x10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

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
