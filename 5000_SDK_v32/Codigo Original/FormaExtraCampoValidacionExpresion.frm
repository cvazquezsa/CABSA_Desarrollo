[Forma]
Clave=FormaExtraCampoValidacionExpresion
Nombre=<T>Validación - Expresión<T>
Icono=0
BarraHerramientas=S
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(<T>Especifique [Valor], [Campo] o [FormaTipo]<T>, Info.Campo)
ListaAcciones=Aceptar
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=598
PosicionInicialArriba=416
PosicionInicialAlturaCliente=332
PosicionInicialAncho=724
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

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

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaExtraCampoExpresion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=FormaExtraCampo.ValidacionExpresion
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=FormaExtraCampo.FormaTipo=<T>{Info.FormaTipo}<T> AND FormaExtraCampo.Campo=<T>{Info.Campo}<T>

[Ficha.FormaExtraCampo.ValidacionExpresion]
Carpeta=Ficha
Clave=FormaExtraCampo.ValidacionExpresion
Editar=S
LineaNueva=S
3D=S
Tamano=100x20
ColorFondo=Blanco
ColorFuente=Negro
